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

choose_action_computer(Board, NewBoard, Player):-
        repeat,
        nl,
        findall([MRow,MColumn],matrixred(Board, MRow, MColumn),RedPieces),
        length(RedPieces,Len),
        format('REDPIECES: ~w ', [RedPieces]),
        random(0,Len,N),
        nth0(N, RedPieces, Coords),
        nth0(0, Coords, Column1),
        nth0(1, Coords, Row1),
        format('Coords: ~w ~w ', [Row1,Column1]),
        findall([CurrentMove], validateComputerMove(Row1, Column1, Row2, Column2, Board, CurrentMove), Moves),
        format('Moves: ~w', [Moves]),
        length(Moves,LenMoves),
        random(0,LenMoves,M),
        nth0(M, Moves, Move),
        nth0(0, Move, CurrentMove),
        format('current: ~w',[CurrentMove]),
        move(CurrentMove, Row1, Column1, Board, NewBoard),
        !.

        /*
            nth0(J, Matrix, Row),
            nth0(I, Row, Value),
        between(0,10,Row),
        gen_piece(Row),*/


/*
gen_piece(Row):-
        repeat,
        between(0,10,Column),
        format('X: ~w Y: ~w', [Row,Column]),
        !,
        fail.*/


check_if_invalid_piece(Row, Column, Board, _):-
        getPiece(Row, Column, Board, Piece),
        (Piece == emptyCell ; Piece == redCityPiece ; Piece == blackCityPiece),
        write('This piece cannot be moved.'), nl,
        !, fail.

check_if_invalid_piece(Row, Column, Board, Player):-
        getPiece(Row, Column, Board, Piece),
        Player == red,
        Piece == blackSoldier,
        write('Red player can only move red soldiers.'), nl,
        !, fail.

check_if_invalid_piece(Row, Column, Board, Player):-
        getPiece(Row, Column, Board, Piece),
        Player == black,
        Piece == redSoldier,
        write('Black player can only move black soldiers.'), nl,
        !, fail.

check_if_invalid_piece(_, _, _, _).

choose_move_option(Row, Column, Board, 1, NewBoard, move_choice(Row, Column, Board, NewBoard)).
choose_move_option(Row, Column, Board, 2, NewBoard, capture_choice(Row, Column, Board, NewBoard)).
choose_move_option(Row, Column, Board, 3, NewBoard, cannon_choice(Row, Column, Board, NewBoard)).

/* to move piece forward */
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

findall_cannon_possibledirections(Row, Column, Board, Piece, Check, ReturnList):-
        Check = ask,
        findall([CannonType, PieceNumber], checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber), ReturnList),
        length(ReturnList, Size),
        Size > 1.

findall_cannon_possibledirections(_,_, _, _, Check, _):-
        Check = dont.

print_list([H|T], I):-
        format('~w - ~w', [I, H]), nl,
        I1 is I+1,
        print_list(T, I1).

print_list([], _).

find_list_element(ReturnList, Number, CannonType, PieceNumber).

ask_which_cannon(ReturnList, Row, Column, Board, Piece, CannonType, PieceNumber):-
        write('Which cannon? '), nl,
        print_list(ReturnList, 1),
        write('Answer: '),
        read(Number),
        find_list_element(ReturnList, Number, CannonType, PieceNumber).

cannon_choice(Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        findall_cannon_possibledirections(Row, Column, Board, Piece, Check, ReturnList),
        Check == ask,
        /* ask predicates */
        ask_which_cannon(ReturnList, Row, Column, Board, Piece, CannonType, PieceNumber),
        write('Move cannon(5), or capture with cannon(6)? '),
        read(Answer),
        choose_cannon_option(Row, Column, Board, NewBoard, CannonType, PieceNumber, Answer, FinalAction),
        FinalAction.

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

/* choosing city - Player vs Player */
humanVsHumanPlaceCity(Board, NewBoard, RedCityColumn, BlackCityColumn):-
        write('Red player place your city!'), nl,
        placeCity(Board, TempBoard, red, RedCityColumn),
        write('Black player place your city!'), nl,
        placeCity(TempBoard, NewBoard, black, BlackCityColumn).

/* choosing city - Player vs Computer */
humanVsComputerPlaceCity(Board, NewBoard, RedCityColumn, BlackCityColumn):-
        write('Red is now choosing city placement'), nl,
        placeCityComputer(Board, TempBoard, red, RedCityColumn),
        write('Black player place your city!'), nl,
        placeCity(TempBoard, NewBoard, black, BlackCityColumn).

placeCityComputer(Board, NewBoard, Player, RedCityColumn):-
        Player == red,
        sleep(1),
        random(1,9,RedCityColumn),
        replaceInMatrix(Board, 0, RedCityColumn, redCityPiece, NewBoard),
        display_game(NewBoard).


placeCity(Board, NewBoard, Player, RedCityColumn):-
        Player == red,
        write('Where to place?'), nl,
        askColumn(RedCityColumn),
        validateCityPlace(RedCityColumn, Player),
        replaceInMatrix(Board, 0, RedCityColumn, redCityPiece, NewBoard),
        display_game(NewBoard).

placeCity(Board, NewBoard, Player, BlackCityColumn):-
        Player == black,
        write('Where to place?'), nl,
        askColumn(BlackCityColumn),
        validateCityPlace(BlackCityColumn, Player),
        replaceInMatrix(Board, 9, BlackCityColumn, blackCityPiece, NewBoard),
        display_game(NewBoard).

/* Main game loop */
/* Eventually, all logic will go here, tying down all the other .pl files, as of now only prints the intermedium board */

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

/* TODO: humanVsComputer:-
TODO: computerVsComputer */
