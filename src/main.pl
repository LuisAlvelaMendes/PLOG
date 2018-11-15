/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

:-include('valid_moves.pl').
:-include('valid_computer_moves.pl').
:-include('value.pl').
:-include('choose_move.pl').
:-include('game_over.pl').
:-include('menu.pl').
:-include('display_game.pl').
:-include('move.pl').
:-include('utilities.pl').

:- use_module(library(random)).
:- use_module(library(system)).
:- use_module(library(between)).

/* Main game running file, contains game loop */

/* Menu loop */
cannon:-
        repeat,
        mainMenu,
        write('Enter game mode: '),
        read(Selection),
        Selection >= 1,
        Selection =< 3,
        initialBoard(Board),
        display_game(Board),
        /* first thing to do in any gamemode is to place the city */
        menuOptionCityPlacement(Selection, Board, NewBoard, RedCityColumn, BlackCityColumn, CityPlacementMethod),
        CityPlacementMethod,
        menuOptionMainGame(Selection, NewBoard, RedCityColumn, BlackCityColumn, GameMode),
        GameMode, !.

/* Each menu option will have matching city placement predicates to start the game */
menuOptionCityPlacement(1, Board, NewBoard, RedCityColumn, BlackCityColumn, humanVsHumanPlaceCity(Board, NewBoard, RedCityColumn, BlackCityColumn)).
menuOptionCityPlacement(2, Board, NewBoard, RedCityColumn, BlackCityColumn, humanVsComputerPlaceCity(Board, NewBoard, RedCityColumn, BlackCityColumn)).
menuOptionCityPlacement(3, Board, NewBoard, RedCityColumn, BlackCityColumn, computerVsComputer(Board, NewBoard, RedCityColumn, BlackCityColumn)).

/* Each menu option will have a matching selection for what game to play's main logic */
menuOptionMainGame(1, Board, RedCityColumn, BlackCityColumn, humanVsHuman(Board, RedCityColumn, BlackCityColumn)).
menuOptionMainGame(2, Board, RedCityColumn, BlackCityColumn, humanVsComputer(Board, RedCityColumn, BlackCityColumn)).
menuOptionMainGame(3, Board, RedCityColumn, BlackCityColumn, computerVsComputer(Board, RedCityColumn, BlackCityColumn)).

/* HUMANS logic */

/* choosing city - Player vs Player */
humanVsHumanPlaceCity(Board, NewBoard, RedCityColumn, BlackCityColumn):-
        write('Red player place your city!'), nl,
        placeCity(Board, TempBoard, red, RedCityColumn),
        write('Black player place your city!'), nl,
        placeCity(TempBoard, NewBoard, black, BlackCityColumn).

/* choosing actions within the game */
choose_action(Board, NewBoard, Player):-
        repeat,
        nl,
        write('Select your piece!'), nl,
        askCoords(Row, Column),
        check_if_invalid_piece(Row, Column, Board, Player),
        write('Would you like to move (either retreat/forward) (1), capture (2), cannon(3)? '),
        read(Answer),
        choose_move_option(Row, Column, Board, Answer, NewBoard, Action),
        Action, !.

choose_move_option(Row, Column, Board, 1, NewBoard, move_choice(Row, Column, Board, NewBoard)).
choose_move_option(Row, Column, Board, 2, NewBoard, capture_choice(Row, Column, Board, NewBoard)).
choose_move_option(Row, Column, Board, 3, NewBoard, cannon_choice(Row, Column, Board, NewBoard)).

/* move and capture */
move_choice(Row, Column, Board, NewBoard):-
        write('Where do you want to move?'), nl,
        askCoords(Row1, Column1),
        validateMove(Row, Column, Row1, Column1, Board, CurrentMove),
        move(CurrentMove, Row, Column, Board, NewBoard).

capture_choice(Row, Column, Board, NewBoard):-
        write('Capture target?'), nl,
        askCoords(Row1, Column1),
        validateCapture(Row, Column, Row1, Column1, Board, Position),
        move(Position, Row, Column, Board, NewBoard).

/* cannons */
check_number_valid(Number, FinalNumber):- Number < FinalNumber, Number >= 0.    

ask_which_cannon(ReturnList, CannonType, PieceNumber):-
        repeat, nl,
        write('Which cannon? '), nl,
        print_list(ReturnList, 0, FinalNumber),
        write('Answer: '),
        read(Number),
        check_number_valid(Number, FinalNumber),
        find_list_element(ReturnList, Number, CannonType, PieceNumber).

cannon_choice(Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        findall_cannon_possibledirections(Row, Column, Board, Piece, Check, ReturnList),
        Check == ask,
        ask_which_cannon(ReturnList, CannonType, PieceNumber),
        write('Move cannon(5), or capture with cannon(6)? '),
        read(Answer),
        choose_cannon_option(Row, Column, Board, NewBoard, CannonType, PieceNumber, Answer, FinalAction),
        FinalAction.

cannon_choice(Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        findall_cannon_possibledirections(Row, Column, Board, Piece, Check, _),
        Check == dont,
        checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber),
        write('Move cannon(5), or capture with cannon(6)? '),
        read(Answer),
        choose_cannon_option(Row, Column, Board, NewBoard, CannonType, PieceNumber, Answer, FinalAction),
        FinalAction.

cannon_choice(_, _, _, _):-
        write('Invalid input!'), nl, fail.

choose_cannon_option(Row, Column, Board, NewBoard, CannonType, PieceNumber, 5, move_cannon_choice(Row, Column, Board, NewBoard, CannonType, PieceNumber)).
choose_cannon_option(Row, Column, Board, NewBoard, CannonType, PieceNumber, 6, capture_cannon_choice(Row, Column, Board, NewBoard, CannonType, PieceNumber)).

move_cannon_choice(Row, Column, Board, NewBoard, CannonType, PieceNumber):-
        write('Where do you want to move?'), nl,
        askCoords(Row1, Column1),
        validateMoveCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber, CurrentMove),
        write(CurrentMove), nl,
        move_cannon(CurrentMove, Row, Column, Board, NewBoard, CannonType, PieceNumber).

capture_cannon_choice(Row, Column, Board, NewBoard, CannonType, PieceNumber):-
        write('Which target do you want to shoot?'), nl,
        askCoords(Row1, Column1),
        validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber),
        capture_cannon(Row1, Column1, Board, NewBoard).

/* Main game loop */

humanVsHuman(Board, RedCityColumn, BlackCityColumn):-
        write('Red player turn!'), nl,
        choose_action(Board, N, red),
        display_game(N),
        \+ game_over(N, RedCityColumn, BlackCityColumn),
        write('Black player turn!'), nl,
        choose_action(N, FinalBoard, black),
        display_game(FinalBoard),
        \+ game_over(FinalBoard, RedCityColumn, BlackCityColumn),
        humanVsHuman(FinalBoard, RedCityColumn, BlackCityColumn).

humanVsHuman(_, _, _):- write('Game Over!'), nl.

/* COMPUTER logic */

/* choosing city - Player vs Computer */
humanVsComputerPlaceCity(Board, NewBoard, RedCityColumn, BlackCityColumn):-
        write('Red is now choosing city placement'), nl,
        placeCityComputer(Board, TempBoard, red, RedCityColumn),
        write('Black player place your city!'), nl,
        placeCity(TempBoard, NewBoard, black, BlackCityColumn).

/* choosing an action presuming bot has nearby enemies he will either capture or retreat, else, he will move */
choose_action_computer(Board, NewBoard, Player):-
        Player == red,
        nl,
        findall([MRow,MColumn],matrixred(Board, MColumn, MRow),RedPieces),
        length(RedPieces,Len),
        random(0,Len,N),
        nth0(N, RedPieces, Coords),
        nth0(0, Coords, Row),
        nth0(1, Coords, Column),
        
        (checkComputerNearbyEnemies(Row, Column, Board) ->
         
        /* found nearby enemy */
        /* tries to retreat if possible, if not, will capture */
       
        choose_to_capture_or_retreat(Row, Column, Board, NewBoard, _)
        
        ;
         
        /* move the piece */
        choose_to_move_computer(Row, Column, Board, NewBoard, _)
        
        ).

/* retreat */
choose_to_capture_or_retreat(Row1, Column1, Board, NewBoard, CurrentMove):-
        write('entered retreat'), nl, 
        findall([CurrentMove], validateComputerRetreat(Row1, Column1, _, _, Board, CurrentMove), Moves),
        length(Moves,LenMoves),
        random(0,LenMoves,M),
        nth0(M, Moves, Move),
        nth0(0, Move, CurrentMove),
        move(CurrentMove, Row1, Column1, Board, NewBoard).

/* capture*/
choose_to_capture_or_retreat(Row1, Column1, Board, NewBoard, Position):-
        write('no retreat possible, capturing'), nl,
        write('entered capture'), nl,
        findall([Position], validateComputerCapture(Row1, Column1, _, _, Board, Position), Positions),
        length(Positions,LenPositions),
        random(0,LenPositions,M),
        nth0(M, Positions, Pos),
        nth0(0, Pos, Position),
        move(Position, Row1, Column1, Board, NewBoard).

choose_to_move_computer(Row1, Column1, Board, NewBoard, CurrentMove):-
        findall([CurrentMove], validateComputerMove(Row1, Column1, _, _, Board, CurrentMove), Moves),
        length(Moves,LenMoves),
        random(0,LenMoves,M),
        nth0(M, Moves, Move),
        nth0(0, Move, CurrentMove),
        move(CurrentMove, Row1, Column1, Board, NewBoard).

/* Main loop */

humanVsComputer(Board, RedCityColumn, BlackCityColumn):-
        write('Red player turn!'), nl,
        choose_action_computer(Board, N, red),
        display_game(N),
        \+ game_over(N, RedCityColumn, BlackCityColumn),
        write('Black player turn!'), nl,
        choose_action(N, FinalBoard, black),
        display_game(FinalBoard),
        \+ game_over(FinalBoard, RedCityColumn, BlackCityColumn),
        humanVsComputer(FinalBoard, RedCityColumn, BlackCityColumn).

humanVsComputer(_, _, _):- write('Game Over!'), nl.


/* TODO: computerVsComputer */
