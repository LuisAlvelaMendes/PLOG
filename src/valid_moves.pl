/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(aggregate)).
:- use_module(library(lists)).
:- use_module(library(clpfd)).

/* Obtenção de uma lista de jogadas possíveis valid_moves(+Board, +Player, -ListOfMoves) */

/* Option 1: move soldier */

/* Option 1.1: forward */
/* A soldier can move forward if the adjacent points in front are free */

/* Predicate to determine frontal adjacency (checks if the spot is empty so he can move) */

/* Right side position, 1 row head and one column to the right */
moveRightAdjacent(Row, Column, Row1, Column1, Board):-
  Row1 is Row + 1,
  Column1 is Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1,Column1, Board, Piece),
  Piece == emptyCell.

/* Left side position, 1 row head and one column to the left */
moveLeftAdjacent(Row, Column, Row1, Column1, Board):-
  Row1 is Row + 1,
  Column1 is Column - 1,
  Row1 =< 9,
  Column1 >= 0,
  getPiece(Row1,Column1, Board, Piece),
  Piece == emptyCell.

/* Position directly in front */
moveFrontAdjacent(Row, Column, Row1, Column, Board):-
  Row1 is Row + 1,
  Row1 =< 9,
  getPiece(Row1,Column, Board, Piece),
  Piece = emptyCell.

/* Option 1.2: capture */

/* Option 1.3: retreat */

/* Option 2: use cannon */

/* Option 2.1: capture cannon */

/* Option 2.2: move cannon */