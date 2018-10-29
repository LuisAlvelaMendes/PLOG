/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(aggregate)).
:- use_module(library(lists)).
:- use_module(library(clpfd)).

/* Obten��o de uma lista de jogadas poss�veis valid_moves(+Board, +Player, -ListOfMoves) */

/* Option 1: move soldier */

/* Option 1.1: forward */
/* A soldier can move forward if the adjacent points in front are free */

/* Predicate to determine frontal adjacency (checks if the spot is empty so he can move) */

/* Right side position, 1 row head and one column to the right */

/* Relative to red soldiers */

/* com as funçoes que fiz:
Ex:
moveRightAdjacentFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  pieceUpRight(Row,Column,Board,OtherPiece),
  OtherPiece == emptyCell.  ?

*/

moveRightAdjacentFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Column1 is Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Relative to black soldiers */
moveLeftAdjacentFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Column1 is Column + 1,
  Row1 >= 0,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Left side position, 1 row head and one column to the left */

/* Relative to red soldiers */
moveLeftAdjacentFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Column1 is Column - 1,
  Row1 =< 9,
  Column1 >= 0,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Relative to black soldiers */
moveRightAdjacentFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Column1 is Column - 1,
  Row1 >=0,
  Column1 >=0,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Position directly in front */

/* Relative to red soldiers */
moveFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece == emptyCell.

/* Relative to black soldiers */
moveFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Row1 >= 0,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece = emptyCell.

/* Option 1.2: capture */

/* A soldier can capture if the adjacent points in front have a enemies piece */

/* Left side position, one column to the left */

/* Relative to red soldiers */
captureLeft(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Column1 is Column - 1,
  Column1 >= 0,
  getPiece(Row,Column1, Board, OtherPiece),
  OtherPiece = blackSoldier.

/* Relative to black soldiers */
captureRight(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Column1 is Column - 1,
  Column1 >= 0,
  getPiece(Row,Column1, Board, OtherPiece),
  OtherPiece = redSoldier.

/* Relative to red soldiers */
captureLeftAdjacentFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Row1 <= 9,
  Column1 is Column - 1,
  Column1 >= 0,
  getPiece(Row,Column1, Board, OtherPiece),
  OtherPiece = blackSoldier.

/* Relative to black soldiers */
captureRightAdjacentFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Row1 >= 0,
  Column1 is Column - 1,
  Column1 >= 0,
  getPiece(Row1,Column1, Board, OtherPiece),
  OtherPiece = redSoldier.

  /* Right side position, one column to the right */

  /* Relative to red soldiers */
  captureRight(Row, Column, Board):-
    getPiece(Row, Column, Board, Piece),
    Piece == redSoldier,
    Column1 is Column + 1,
    Column1 <= 9,
    getPiece(Row,Column1, Board, OtherPiece),
    OtherPiece = blackSoldier.

  /* Relative to black soldiers */
  captureLeft(Row, Column, Board):-
    getPiece(Row, Column, Board, Piece),
    Piece == blackSoldier,
    Column1 is Column + 1,
    Column1 <= 9,
    getPiece(Row,Column1, Board, OtherPiece),
    OtherPiece = redSoldier.

  /* Relative to red soldiers */
  captureRightAdjacentFront(Row, Column, Board):-
    getPiece(Row, Column, Board, Piece),
    Piece == redSoldier,
    Row1 is Row + 1,
    Row1 <= 9,
    Column1 is Column + 1,
    Column1 <= 9,
    getPiece(Row1,Column1, Board, OtherPiece),
    OtherPiece = blackSoldier.

  /* Relative to black soldiers */
  captureLeftAdjacentFront(Row, Column, Board):-
    getPiece(Row, Column, Board, Piece),
    Piece == blackSoldier,
    Row1 is Row - 1,
    Row1 >= 0,
    Column1 is Column + 1,
    Column1 <= 9,
    getPiece(Row1,Column1, Board, OtherPiece),
    OtherPiece = redSoldier.

/* Capture directly in front */

/* Relative to red soldiers */
captureFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece == blackSoldier.

/* Relative to black soldiers */
captureFront(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Row1 >= 0,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece = redSoldier.


/* Option 1.3: retreat */

/* A soldier can retreat if there is at least one enemy piece in nearby cells */

/* It can move only 2 cells backwards orthogonal or diagonal*/

/* Left side, 2 row back and two columns to the left */

/* Relative to red soldiers */
  retreatLeft(Row, Column, Board):-
    /* Verify if there is an adjacent enemy piece */
    adjacentEnemy(Row,Column,Board,EnemyPiece),
    EnemyPiece == blackSoldier.
    /* Verify if the two cells are empty ( nao sei se podemos reutilizar o otherpiece. se calhar temos de fazer loop )*/
    getPiece(Row, Column, Board, Piece),
    Piece == redSoldier,
    pieceDownLeft(Row,Column,Board,OtherPiece),
    OtherPiece == emptyCell,
    Row1 is Row - 1,
    Column1 is Column - 1,
    pieceDownLeft(Row1,Column1,Board,OtherPiece),
    OtherPiece = emptyCell,

/* Relative to black soldiers */
  retreatRight(Row, Column, Board):-
    /* Verify if there is an adjacent enemy piece */
    adjacentEnemy(Row,Column,Board,EnemyPiece),
    EnemyPiece == blackSoldier.
    /* Verify if the two cells are empty ( nao sei se podemos reutilizar o otherpiece. se calhar temos de fazer loop )*/
    getPiece(Row, Column, Board, Piece),
    Piece == blackSoldier,
    pieceUpLeft(Row,Column,Board,OtherPiece),
    OtherPiece == emptyCell,
    Row1 is Row + 1,
    Column1 is Column - 1,
    pieceUpLeft(Row1,Column1,Board,OtherPiece),
    OtherPiece = emptyCell,



/* Relative to black soldiers */
  captureRight(Row, Column, Board):-
    getPiece(Row, Column, Board, Piece),
    Piece == blackSoldier,
    Row1 is Row - 1,
    Row1 >= 0,
    Column1 is Column + 1,
    Column1 <= 9,
    getPiece(Row,Column1, Board, OtherPiece),
    OtherPiece = redSoldier.





/* Option 2: use cannon */

/* Option 2.1: capture cannon */

/* Option 2.2: move cannon */

/* Utility functions */
  pieceUp(Row,Column,Board,Piece):-
    Row1 is Row + 1,
    Row1 =< 9,
    getPiece(Row1, Column, Board, RealPiece).
    Piece=RealPiece.

  pieceDown(Row,Column,Board,Piece):-
    Row1 is Row - 1,
    Row1 >= 0,
    getPiece(Row1, Column, Board, RealPiece).
    Piece=RealPiece.

  pieceRight(Row,Column,Board,Piece):-
    Column1 is Column + 1,
    Column1 =< 9,
    getPiece(Row, Column1, Board, RealPiece).
    Piece=RealPiece.

  pieceLeft(Row,Column,Board,Piece):-
    Column1 is Column - 1,
    Column1 >= 0,
    getPiece(Row, Column1, Board, RealPiece).
    Piece=RealPiece.

  pieceUpLeft(Row,Column,Board,Piece):-
    Row1 is Row + 1,
    Row1 =< 9,
    Column1 is Column - 1,
    Column1 >= 0,
    getPiece(Row1, Column1, Board, RealPiece).
    Piece=RealPiece.

  pieceUpRight(Row,Column,Board,Piece):-
    Row1 is Row + 1,
    Row1 =< 9,
    Column1 is Column + 1,
    Column1 <= 9,
    getPiece(Row1, Column1, Board, RealPiece).
    Piece=RealPiece.

  pieceDownLeft(Row,Column,Board,Piece):-
    Row1 is Row - 1,
    Row1 >= 0,
    Column1 is Column - 1,
    Column1 >= 0,
    getPiece(Row1, Column1, Board, RealPiece).
    Piece=RealPiece.

  pieceDownRight(Row,Column,Board,Piece):-
    Row1 is Row - 1,
    Row1 >= 0,
    Column1 is Column + 1,
    Column1 <= 9,
    getPiece(Row1, Column1, Board, RealPiece).
    Piece=RealPiece.

  adjacentEnemy(Row,Column,Board,Piece):-
    pieceUp(Row,Column,Board,Piece);
    pieceDown(Row,Column,Board,Piece);
    pieceRight(Row,Column,Board,Piece);
    pieceLeft(Row,Column,Board,Piece);
    pieceUpRight(Row,Column,Board,Piece);
    pieceUpLeft(Row,Column,Board,Piece);
    pieceDownLeft(Row,Column,Board,Piece);
    pieceDownRight(Row,Column,Board,Piece).
