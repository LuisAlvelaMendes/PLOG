/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(aggregate)).
:- use_module(library(lists)).
:- use_module(library(clpfd)).

/* Obtenção de uma lista de jogadas possíveis valid_moves(+Board, +Player, -ListOfMoves) */

/* Option 0: place city, placing the city also counts as part of the game, and the city must be placed in a given row without counting the corners */
validatePlaceRedCityPiece(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redCityPiece,
  Row == 0,
  Column \= 0,
  Column \= 9.

validatePlaceBlackCityPiece(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackCityPiece,
  Row == 9,
  Column \= 0,
  Column \= 9.

/* Option 1: move soldier */

/* Option 1.1: forward */
/* A soldier can move forward if the adjacent points in front are free */

/* Predicate to determine frontal adjacency (checks if the spot is empty so he can move) */

/* Right side position, 1 row head and one column to the right */

/* Relative to red soldiers */
validateMoveRightAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Column1 is Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Relative to black soldiers */
validateMoveLeftAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Column1 is Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Left side position, 1 row head and one column to the left */

/* Relative to red soldiers */
validateMoveLeftAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Column1 is Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Relative to black soldiers */
validateMoveLeftAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Column1 is Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Position directly in front */

/* Relative to red soldiers */
validateMoveFront(Row, Column, Row1, _, Board):-      
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Relative to black soldiers */
validateMoveFront(Row, Column, Row1, _, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece = emptyCell.

/* A valid movement can be, for example, forward */
validateMove(Row, Column, Row1, Column1, Board):- validateMoveFront(Row, Column, Row1, Column1, Board) ; validateMoveLeftAdjacentFront(Row, Column, Row1, Column1, Board) ; validateMoveRightAdjacentFront(Row, Column, Row1, Column1, Board).

/* Another would be retreating */
/* validateMove:- retreatBack ; retreatLeft ; retreatRight */

/* And if neither of those checked out, then he picked an invalid movement option .. */
validateMove(_, _, _, _, _):- write('Invalid cell to move to! Select again ..'), nl, fail.

/* Option 1.2: capture */

/* Option 1.3: retreat */

/* Option 2: use cannon */

/* Option 2.1: capture cannon */

/* Option 2.2: move cannon */