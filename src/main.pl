/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

:-include('valid_moves.pl').
:-include('value.pl').
:-include('choose_move.pl').
:-include('game_over.pl').
:-include('menu.pl').
:-include('display_game.pl').
:-include('move.pl').
:-include('utilities.pl').

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
        menuOptionCityPlacement(Selection, Board, NewBoard, CityPlacementMethod),
        CityPlacementMethod,
        menuOptionMainGame(Selection, NewBoard, GameMode),
        GameMode, !.

/* each menu option will have matching city placement predicates to start the game */
menuOptionCityPlacement(1, Board, NewBoard, humanVsHumanPlaceCity(Board, NewBoard)).
menuOptionCityPlacement(2, Board, NewBoard, humanVsComputerPlaceCity(Board, NewBoard)).
menuOptionCityPlacement(3, Board, NewBoard, computerVsComputer(Board, NewBoard)).

/* Each menu option will have a matching selection for what game to play's main logic */
menuOptionMainGame(1, Board, humanVsHuman(Board)).
menuOptionMainGame(2, Board, humanVsComputer(Board)).
menuOptionMainGame(3, Board, computerVsComputer(Board)).

/* choosing actions within the game */
choose_action(Board, NewBoard, Player):-
        repeat,
        write('Select your piece!'), nl,
        askCoords(Row, Column),
        check_if_invalid_piece(Row, Column, Board, Player),
        write('Would you like to move (either retreat/forward) (1), capture (2), cannon(3)? '),
        read(Answer),
        choose_move_option(Row, Column, Board, Answer, NewBoard, Action),
        Action, !.

check_if_invalid_piece(Row, Column, Board, _):-
        getPiece(Row, Column, Board, Piece),
        (Piece == emptyCell ; Piece == redCityPiece ; Piece == blackCityPiece),
        write('This piece cannot be moved.'), nl,
        fail, !.

check_if_invalid_piece(Row, Column, Board, Player):-
        getPiece(Row, Column, Board, Piece),
        Player == red,
        Piece == blackSoldier,
        write('Red player can only move red soldiers.'), nl,
        fail, !.

check_if_invalid_piece(Row, Column, Board, Player):-
        getPiece(Row, Column, Board, Piece),
        Player == black,
        Piece == redSoldier,
        write('Black player can only move black soldiers.'), nl,
        fail, !.

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

/*TODO: define retreat validation/execution predicates ..*/
/* capture_choice(Row, Column, Board):- */

cannon_choice(Row, Column, Board):- 
        write('Move cannon(5), or capture with cannon(6)? '),
        read(Answer),
        choose_cannon_option(Row, Column, Board, Answer, FinalAction),
        FinalAction.

choose_cannon_option(Row, Column, Board, 5, move_cannon_choice(Row, Column, Board)).
choose_cannon_option(Row, Column, Board, 6, capture_cannon_choice(Row, Column, Board)).

/*TODO: define cannon validation/execution predicates ..*/
/* cannon_choice(Row, Column, Board):- */

/* choosing city with humans */
humanVsHumanPlaceCity(Board, NewBoard):-
        write('Red player place your city!'), nl,
        placeCity(Board, TempBoard, red),
        write('Black player place your city!'), nl,
        placeCity(TempBoard, NewBoard, black).

placeCity(Board, NewBoard, Player):-
        Player == red,
        write('Where to place?'), nl,
        askColumn(Column),
        validateCityPlace(Column, Player),
        replaceInMatrix(Board, 0, Column, redCityPiece, NewBoard),
        display_game(NewBoard).

placeCity(Board, NewBoard, Player):-
        Player == black,
        write('Where to place?'), nl,
        askColumn(Column),
        validateCityPlace(Column, Player),
        replaceInMatrix(Board, 9, Column, blackCityPiece, NewBoard),
        display_game(NewBoard).

/* Main game loop */
/* Eventually, all logic will go here, tying down all the other .pl files, as of now only prints the intermedium board */

humanVsHuman(Board):-
        write('Red player turn!'), nl,
        choose_action(Board, N, red),
        display_game(N),
        write('Black player turn!'), nl,
        choose_action(N, FinalBoard, black),
        display_game(FinalBoard),
        humanVsHuman(FinalBoard).

humanVsHuman(N):- game_over(N), write('Game Over!'), nl.

/* TODO: humanVsComputer:-
TODO: computerVsComputer */