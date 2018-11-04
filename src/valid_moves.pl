/* -*- Mode:Prolog; coding:=:=o-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(aggregate)).
:- use_module(library(lists)).
:- use_module(library(clpfd)).

/* Obtenção de uma l=:=ta de jogadas possíve=:= valid_moves(+Board, +Player, -L=:=tOfMoves) */

/* Option 0: place city, placing the city also counts as part of the game, and the city must be placed in a given row without counting the corners */
validateCityPlace(Column, red):-
  Column \= 0,
  Column \= 9.

validateCityPlace(Column, black):-
  Column \= 0,
  Column \= 9.

/* Option 1: move soldier */

/* Option 1.1: forward */
/* A soldier can move forward if the adjacent points in front are free */

/* Predicate to determine frontal adjacency (checks if the spot =:= empty so he can move) */

/* Right side position, 1 row head and one column to the right */

/* Relative to red soldiers */
validateMoveRightAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 =:= Row + 1,
  Column1 =:= Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell, !.

/* Relative to black soldiers */
validateMoveRightAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row - 1,
  Column1 =:= Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell, !.

/* Left side position, 1 row head and one column to the left */

/* Relative to red soldiers */
validateMoveLeftAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 =:= Row + 1,
  Column1 =:= Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell, !.

/* Relative to black soldiers */
validateMoveLeftAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row - 1,
  Column1 =:= Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell, !.

/* Position directly in front */

/* Relative to red soldiers */
validateMoveFront(Row, Column, Row1, Column1, Board):-      
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 =:= Row + 1,
  Column1 =:= Column,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece == emptyCell, !.

/* Relative to black soldiers */
validateMoveFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row - 1,
  Column1 =:= Column,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece = emptyCell, !.

/* Option 1.3: capture */

/* Frontal Capture */

/* Relative to red soldiers */
validateCaptureFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 =:= Row + 1,
  Column1 =:= Column,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateCaptureFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row - 1,
  Column1 =:= Column,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Left side position, 1 row head and one column to the left */

/* Relative to red soldiers */
validateCaptureLeftAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 =:= Row + 1,
  Column1 =:= Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateCaptureLeftAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row - 1,
  Column1 =:= Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Right side position, 1 row head and one column to the right */

/* Relative to red soldiers */
validateCaptureRightAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 =:= Row + 1,
  Column1 =:= Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateCaptureRightAdjacentFront(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row - 1,
  Column1 =:= Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Left side -actual- left, one column to the left */

/* Relative to red soldiers */
validateCaptureLeftSide(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 =:= Row,
  Column1 =:= Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateCaptureLeftSide(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row,
  Column1 =:= Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Right side -actual- right */

/* Relative to red soldiers */
validateCaptureRightSide(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 =:= Row,
  Column1 =:= Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateCaptureRightSide(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row,
  Column1 =:= Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* to retreat we need a predicate to deterimne if there are enemies nearby */
checkNearbyEnemies(Row, Column, Board):- validateFrontEnemy(Row, Column, Board).
checkNearbyEnemies(Row, Column, Board):- validateLeftAdjacentFrontEnemy(Row, Column, Board).
checkNearbyEnemies(Row, Column, Board):- validateRightAdjacentFrontEnemy(Row, Column, Board).
checkNearbyEnemies(Row, Column, Board):- validateLeftSideEnemy(Row, Column, Board).
checkNearbyEnemies(Row, Column, Board):- validateRightSideEnemy(Row, Column, Board).
checkNearbyEnemies(_, _, _):- write('There are no enemies nearby'), nl.

/* front checking for enemies */

/* red soldier */
validateFrontEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* black soldier */
validateFrontEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Left side position, 1 row head and one column to the left */

/* Relative to red soldiers */
validateLeftAdjacentFrontEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Column1 is Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateLeftAdjacentFrontEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Column1 is Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Right side position, 1 row head and one column to the right */

/* Relative to red soldiers */
validateRightAdjacentFrontEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row + 1,
  Column1 is Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateRightAdjacentFrontEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Column1 is Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Left side -actual- left, one column to the left */

/* Relative to red soldiers */
validateLeftSideEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row,
  Column1 is Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateLeftSideEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row,
  Column1 is Column - 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Right side -actual- right */

/* Relative to red soldiers */
validateRightSideEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  Row1 is Row,
  Column1 is Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateRightSideEnemy(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 =:= Row,
  Column1 =:= Column + 1,
  Row1 =< 9,
  Column1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == redSoldier ; OtherPiece == redCityPiece).

/* Option 1.2: retreat */

/* directly backwards */

/* relative to red soldiers */
validateRetreatBack(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row - 2,
  Column1 =:= Column,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece == emptyCell, !.

/* relative to black soldiers */
validateRetreatBack(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row + 2,
  Column1 =:= Column,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece == emptyCell, !.
        
/* backwards to the left diagonal */

/* relative to red soldiers */
validateRetreatLeft(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier, 
  checkNearbyEnemies(Row, Column, Board), 
  Row1 =:= Row - 2,
  Column1 =:= Column - 1,
  Row1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell, !.

/* relative to black soldiers */
validateRetreatLeft(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row + 2,
  Column1 =:= Column - 1,
  Row1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell, !.

/* backwards to the right diagonal */

/* relative to red soldiers */
validateRetreatRight(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row - 2,
  Column1 =:= Column + 1,
  Row1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell, !.   

/* relative to black soldiers */
validateRetreatRight(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row + 2,
  Column1 =:= Column + 1,
  Row1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell, !.   

/* A valid movement can be forwards or backwards */
validateMove(Row, Column, Row1, Column1, Board, CurrentMove):- validateMoveFront(Row, Column, Row1, Column1, Board), CurrentMove = front.
validateMove(Row, Column, Row1, Column1, Board, CurrentMove):- validateMoveLeftAdjacentFront(Row, Column, Row1, Column1, Board), CurrentMove = frontLeft.
validateMove(Row, Column, Row1, Column1, Board, CurrentMove):- validateMoveRightAdjacentFront(Row, Column, Row1, Column1, Board), CurrentMove = frontRight.
validateMove(Row, Column, Row1, Column1, Board, CurrentMove):- validateRetreatBack(Row, Column, Row1, Column1, Board), CurrentMove = back.
validateMove(Row, Column, Row1, Column1, Board, CurrentMove):- validateRetreatLeft(Row, Column, Row1, Column1, Board), CurrentMove = backLeft.
validateMove(Row, Column, Row1, Column1, Board, CurrentMove):- validateRetreatRight(Row, Column, Row1, Column1, Board), CurrentMove = backRight.

/* And if neither of those checked out, then he picked an invalid movement option .. */
validateMove(_, _, _, _, _, _):- write('Invalid cell to move to! Select again ..'), nl, fail.

/* A valid capture can only be in the follwing ways */
validateCapture(Row, Column, Row1, Column1, Board, Position):- validateCaptureFront(Row, Column, Row1, Column1, Board), Position = front.
validateCapture(Row, Column, Row1, Column1, Board, Position):- validateCaptureLeftAdjacentFront(Row, Column, Row1, Column1, Board), Position = frontLeft.
validateCapture(Row, Column, Row1, Column1, Board, Position):- validateCaptureRightAdjacentFront(Row, Column, Row1, Column1, Board), Position = frontRight.
validateCapture(Row, Column, Row1, Column1, Board, Position):- validateCaptureLeftSide(Row, Column, Row1, Column1, Board), Position = leftSide.
validateCapture(Row, Column, Row1, Column1, Board, Position):- validateCaptureRightSide(Row, Column, Row1, Column1, Board), Position = rightSide.

validateCapture(_, _, _, _, _, _):- write('Invalid cell to capture! Select again ..'), nl, fail.


/* Option 2: use cannon */

/* Option 2.1: capture cannon */

/* Option 2.2: move cannon */