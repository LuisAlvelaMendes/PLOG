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
        write('Enter game mode '),
        read(Selection),
        Selection >= 1,
        Selection =< 3,
        menuOption(Selection, GameMode),
        GameMode.

/* Each menu option will have a matching selection for what game to play */
menuOption(1, humanVsHuman).
menuOption(2, humanVsComputer).
menuOption(3, computerVsComputer).

/* choosing actions within the game */
choose_action(Board):-
        repeat,
        write('Select your piece!'), nl,
        askCoords(Row, Column),
        check_if_invalid_piece(Row, Column, Board),
        write('Would you like to move (either retreat/forward) (1), capture (2), cannon(3)? '),
        read(Answer),
        choose_move_option(Row, Column, Board, Answer, Action),
        Action.

check_if_invalid_piece(Row, Column, Board):-
        getPiece(Row, Column, Board, Piece),
        (Piece == emptyCell ; Piece == redCityPiece ; Piece == blackCityPiece),
        write('Invalid piece.'), nl,
        choose_action(Board). 

check_if_invalid_piece(_, _, _).                                       

choose_move_option(Row, Column, Board, 1, move_choice(Row, Column, Board)).
choose_move_option(Row, Column, Board, 2, capture_choice(Row, Column, Board)).
choose_move_option(Row, Column, Board, 3, cannon_choice(Row, Column, Board)).

/* to move piece forward */
move_choice(Row, Column, Board):-
        repeat,
        write('Where do you want to move?'), nl,
        askCoords(Row1, Column1),
        validateMove(Row, Column, Row1, Column1, Board).                                                                                                 

/*TODO: define retreat validation/execution predicates ..*/
/* capture_choice(Row, Column, Board):- */

cannon_choice(Row, Column, Board):- 
        repeat,
        write('Move cannon(5), or capture with cannon(6)? '),
        read(Answer),
        choose_cannon_option(Row, Column, Board, Answer, FinalAction),
        FinalAction.

choose_cannon_option(Row, Column, Board, 5, move_cannon_choice(Row, Column, Board)).
choose_cannon_option(Row, Column, Board, 6, capture_cannon_choice(Row, Column, Board)).

/*TODO: define cannon validation/execution predicates ..*/
/* cannon_choice(Row, Column, Board):- */

/* Main game loop */
/* Eventually, all logic will go here, tying down all the other .pl files, as of now only prints the intermedium board */
/* As of now, only prints the atom in a given row and column of the list */

humanVsHuman:-
        intermediumBoard(T), 
        display_game(T),
        choose_action(T).

/* TODO: humanVsComputer:-
TODO: computerVsComputer */