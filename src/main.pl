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
        getInt(Selection),
        Selection >= 1,
        Selection =< 3,
        menuOption(Selection, GameMode),
        GameMode.

/* Each menu option will have a matching selection for what game to play */
menuOption(1, humanVsHuman).
menuOption(2, humanVsComputer).
menuOption(3, computerVsComputer).

/* Main game loop */
/* Eventually, all logic will go here, tying down all the other .pl files, as of now only prints the intermedium board */
/* As of now, only prints the atom in a given row and column of the list */

humanVsHuman:-
        intermediumBoard(T), 
        display_game(T),
        askCoords(Row, Column),
        /*getPiece(Row, Column, T, Piece), 
        write(Piece),*/
        moveFront(Row, Column, T).

/* TODO: humanVsComputer:-
TODO: computerVsComputer */