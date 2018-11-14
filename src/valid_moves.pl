/* -*- Mode:Prolog; coding:=:=o-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(aggregate)).
:- use_module(library(lists)).
:- use_module(library(clpfd)).

/* Obten��o de uma lista de jogadas poss�veis valid_moves(+Board, +Player, -ListOfMoves) faz-se com find all*/

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

/* Predicate to determine frontal adjacency (checks if the spot is empty so he can move) */

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
  Row1 is Row - 1,
  Column1 is Column + 1,
  Row1 >= 0,
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
checkNearbyEnemies(_, _, _):- write('There are no enemies nearby'), nl, !, fail.

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
  Column1 >= 0,
  getPiece(Row1, Column1, Board, OtherPiece),
  (OtherPiece == blackSoldier ; OtherPiece == blackCityPiece).

/* Relative to black soldiers */
validateLeftAdjacentFrontEnemy(Row, Column, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  Row1 is Row - 1,
  Column1 is Column - 1,
  Row1 >=0,
  Column1 >=0,
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
  Row1 >= 0,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece == emptyCell,
  Row2 is Row - 1,
  getPiece(Row2, Column, Board, OtherPiece2),
  OtherPiece2 == emptyCell, !.

/* relative to black soldiers */
validateRetreatBack(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row + 2,
  Column1 =:= Column,
  Row1 =< 9,
  getPiece(Row1, Column, Board, OtherPiece),
  OtherPiece == emptyCell,
  Row2 is Row + 1,
  getPiece(Row2, Column, Board, OtherPiece2),
  OtherPiece2 == emptyCell, !.

/* backwards to the left diagonal */

/* relative to red soldiers */
validateRetreatLeft(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row - 2,
  Column1 =:= Column - 2,
  Row1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell,
  Row2 is Row - 1,
  Column2 is Column - 1,
  getPiece(Row2, Column2, Board, OtherPiece2),
  OtherPiece2 == emptyCell, !.

/* relative to black soldiers */
validateRetreatLeft(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row + 2,
  Column1 =:= Column - 2,
  Row1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell,
  Row2 is Row + 1,
  Column2 is Column - 1,
  getPiece(Row2, Column2, Board, OtherPiece2),
  OtherPiece2 == emptyCell, !.

/* backwards to the right diagonal */

/* relative to red soldiers */
validateRetreatRight(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == redSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row - 2,
  Column1 =:= Column + 2,
  Row1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell,
  Row2 is Row - 1,
  Column2 is Column + 1,
  getPiece(Row2, Column2, Board, OtherPiece2),
  OtherPiece2 == emptyCell, !.

/* relative to black soldiers */
validateRetreatRight(Row, Column, Row1, Column1, Board):-
  getPiece(Row, Column, Board, Piece),
  Piece == blackSoldier,
  checkNearbyEnemies(Row, Column, Board),
  Row1 =:= Row + 2,
  Column1 =:= Column + 2,
  Row1 =< 9,
  getPiece(Row1, Column1, Board, OtherPiece),
  OtherPiece == emptyCell,
  Row2 is Row + 1,
  Column2 is Column + 1,
  getPiece(Row2, Column2, Board, OtherPiece2),
  OtherPiece2 == emptyCell, !.

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

/* Option 2.1: move cannon */

/* first you need a predicate to see if the selected piece is in a cannon line */

/* there are 4 possible cannon lines */

/* line 1: purely vertical line */

/*
   Piece1
   Piece2
   Piece3
*/

/* imagining Piece1 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = verticalCannon,
        PieceNumber = 1,
        Row2 is Row + 1,
        Column2 is Column,
        getPiece(Row2, Column2, Board, BackPiece),
        BackPiece == Piece,
        Row3 is Row + 2,
        Column3 is Column,
        getPiece(Row3, Column3, Board, SecondBackPiece),
        SecondBackPiece == Piece.

/* imagining Piece 2 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = verticalCannon,
        PieceNumber = 2,
        Row1 is Row - 1,
        Column1 is Column,
        getPiece(Row1, Column1, Board, FrontPiece),
        FrontPiece == Piece,
        Row3 is Row + 1,
        Column3 is Column,
        getPiece(Row3, Column3, Board, BackPiece),
        BackPiece == Piece.

/* imagining Piece 3 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = verticalCannon,
        PieceNumber = 3,
        Row1 is Row - 1,
        Column1 is Column,
        getPiece(Row1, Column1, Board, FrontPiece),
        FrontPiece == Piece,
        Row2 is Row - 2,
        Column2 is Column,
        getPiece(Row2, Column2, Board, SecondFrontPiece),
        SecondFrontPiece == Piece.


/* line 2: NW -> SE diagonal line */

/*      Piece1
                Piece2
                        Piece3
*/

/* imagining Piece1 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = diagonalNWSECannon,
        PieceNumber = 1,
        Row2 is Row + 1,
        Column2 is Column + 1,
        getPiece(Row2, Column2, Board, BackPiece),
        BackPiece == Piece,
        Row3 is Row + 2,
        Column3 is Column + 2,
        getPiece(Row3, Column3, Board, SecondBackPiece),
        SecondBackPiece == Piece.


/* imagining Piece 2 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = diagonalNWSECannon,
        PieceNumber = 2,
        Row1 is Row - 1,
        Column1 is Column - 1,
        getPiece(Row1, Column1, Board, FrontPiece),
        FrontPiece == Piece,
        Row3 is Row + 1,
        Column3 is Column + 1,
        getPiece(Row3, Column3, Board, BackPiece),
        BackPiece == Piece.


/* imagining Piece 3 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = diagonalNWSECannon,
        PieceNumber = 3,
        Row1 is Row - 1,
        Column1 is Column - 1,
        getPiece(Row1, Column1, Board, FrontPiece),
        FrontPiece == Piece,
        Row2 is Row - 2,
        Column2 is Column - 2,
        getPiece(Row2, Column2, Board, SecondFrontPiece),
        SecondFrontPiece == Piece.

/* line 3: SW -> NE diagonal line */

/*
                        Piece1
                Piece2
        Piece3
*/

/* imagining Piece1 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = diagonalSWNECannon,
        PieceNumber = 1,
        Row2 is Row + 1,
        Column2 is Column - 1,
        getPiece(Row2, Column2, Board, BackPiece),
        BackPiece == Piece,
        Row3 is Row + 2,
        Column3 is Column - 2,
        getPiece(Row3, Column3, Board, SecondBackPiece),
        SecondBackPiece == Piece.

/* imagining Piece 2 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = diagonalSWNECannon,
        PieceNumber = 2,
        Row1 is Row - 1,
        Column1 is Column + 1,
        getPiece(Row1, Column1, Board, FrontPiece),
        FrontPiece == Piece,
        Row3 is Row + 1,
        Column3 is Column - 1,
        getPiece(Row3, Column3, Board, BackPiece),
        BackPiece == Piece.

/* imagining Piece 3 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = diagonalSWNECannon,
        PieceNumber = 3,
        Row1 is Row - 1,
        Column1 is Column + 1,
        getPiece(Row1, Column1, Board, FrontPiece),
        FrontPiece == Piece,
        Row2 is Row - 2,
        Column2 is Column + 2,
        getPiece(Row2, Column2, Board, SecondFrontPiece),
        SecondFrontPiece == Piece.

/* line 4: purely horizontal line */

/* Piece1 Piece2 Piece3 */

/* imagining Piece1 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = horizontalCannon,
        PieceNumber = 1,
        Row2 is Row,
        Column2 is Column + 1,
        getPiece(Row2, Column2, Board, BackPiece),
        BackPiece == Piece,
        Row3 is Row,
        Column3 is Column + 2,
        getPiece(Row3, Column3, Board, SecondBackPiece),
        SecondBackPiece == Piece.

/* imagining Piece 2 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = horizontalCannon,
        PieceNumber = 2,
        Row1 is Row,
        Column1 is Column + 1,
        getPiece(Row1, Column1, Board, FrontPiece),
        FrontPiece == Piece,
        Row2 is Row,
        Column2 is Column - 1,
        getPiece(Row2, Column2, Board, BackPiece),
        BackPiece == Piece.

/* imagining Piece 3 */
checkPieceInCannon(Row, Column, Board, Piece, CannonType, PieceNumber):-
        CannonType = horizontalCannon,
        PieceNumber = 3,
        Row1 is Row,
        Column1 is Column - 1,
        getPiece(Row1, Column1, Board, FrontPiece),
        FrontPiece == Piece,
        Row2 is Row,
        Column2 is Column - 2,
        getPiece(Row2, Column2, Board, SecondFrontPiece),
        SecondFrontPiece == Piece.

/* now for actual movement validity */

/* forward */

/* vertical line */

/* red cannon */
validateMoveCannonForward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        Piece == redSoldier,
        CannonType == verticalCannon,
        Row1 =:= Row + (4 - PieceNumber),
        Column1 =:= Column,
        getPiece(Row1, Column1, Board, OtherPiece),
        OtherPiece == emptyCell.

/* black cannon */
validateMoveCannonForward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        Piece == blackSoldier,
        CannonType == verticalCannon,
        Row1 =:= Row - PieceNumber,
        Column1 =:= Column,
        getPiece(Row1, Column1, Board, OtherPiece),
        OtherPiece == emptyCell.

/* NW -> SE diagonal line */

validateMoveCannonForward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        CannonType == diagonalNWSECannon,
        Row1 =:= Row - PieceNumber,
        Column1 =:= Column - PieceNumber,
        getPiece(Row1, Column1, Board, Piece),
        Piece == emptyCell.

/* SW -> NE diagonal line */

validateMoveCannonForward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        CannonType == diagonalSWNECannon,
        Row1 =:= Row - PieceNumber,
        Column1 =:= Column + PieceNumber,
        getPiece(Row1, Column1, Board, Piece),
        Piece == emptyCell.

/* Horizontal line */

validateMoveCannonForward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        CannonType == horizontalCannon,
        Row1 =:= Row,
        Column1 =:= Column + (4-PieceNumber),
        getPiece(Row1, Column1, Board, Piece),
        Piece == emptyCell.

/* backward */

/* vertical line */

/* red cannon */
validateMoveCannonBackward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        Piece == redSoldier,
        CannonType == verticalCannon,
        Row1 =:= Row - PieceNumber,
        Column1 =:= Column,
        getPiece(Row1, Column1, Board, OtherPiece),
        OtherPiece == emptyCell.

/* black cannon */
validateMoveCannonBackward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        Piece == blackSoldier,
        CannonType == verticalCannon,
        Row1 =:= Row + (4 - PieceNumber),
        Column1 =:= Column,
        getPiece(Row1, Column1, Board, OtherPiece),
        OtherPiece == emptyCell.

/* NW -> SE diagonal line */

validateMoveCannonBackward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        CannonType == diagonalNWSECannon,
        Row1 =:= Row + (4 - PieceNumber),
        Column1 =:= Column + (4 - PieceNumber),
        getPiece(Row1, Column1, Board, Piece),
        Piece == emptyCell.

/* SW -> NE diagonal line */

validateMoveCannonBackward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        CannonType == diagonalSWNECannon,
        Row1 =:= Row + (4 - PieceNumber),
        Column1 =:= Column - (4-PieceNumber),
        getPiece(Row1, Column1, Board, Piece),
        Piece == emptyCell.

/* Horizontal line */

validateMoveCannonBackward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        CannonType == horizontalCannon,
        Row1 =:= Row,
        Column1 =:= Column - PieceNumber,
        getPiece(Row1, Column1, Board, Piece),
        Piece == emptyCell.

validateMoveCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber, CurrentMove):- validateMoveCannonForward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber), CurrentMove = forward.
validateMoveCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber, CurrentMove):- validateMoveCannonBackward(Row, Column, Row1, Column1, Board, CannonType, PieceNumber), CurrentMove = backward.
validateMoveCannon(_, _, _, _, _, _, _, _):- write('Cannot move there.'), nl, !, fail.

/* Option 2.2: capture cannon */

/* Capture up for both players */

validateCaptureCannonFront(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        CannonType == verticalCannon,
        Column1 is Column,
        Row2 is Row - PieceNumber,
        getPiece(Row2, Column, Board, EmptyPiece),
        EmptyPiece == emptyCell,
        (
        (Row1 =:= Row - (PieceNumber+1),
          getPiece(Row1, Column, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          ))
        )
        ;
          (Row1 =:= Row - (PieceNumber+2),
          getPiece(Row1, Column, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece))
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          )
        ))).

/* Capture up for both players */

validateCaptureCannonBack(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        CannonType == verticalCannon,
        Column1 is Column,
        Row2 is Row + (4-PieceNumber),
        getPiece(Row2, Column, Board, EmptyPiece),
        EmptyPiece == emptyCell,
        (
        (Row1 =:= Row + (5-PieceNumber),
          getPiece(Row1, Column, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          ))
        )
        ;
          (Row1 =:= Row + (5-PieceNumber),
          getPiece(Row1, Column, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
          )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          )
        ))).

/* Capture left for both players */

validateCaptureLeftSide(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        CannonType == horizontalCannon,
        Row1 is Row,
        Column2 is Column - PieceNumber,
        getPiece(Row, Column2, Board, EmptyPiece),
        EmptyPiece == emptyCell,
        (
        (Column1 =:= Column - (PieceNumber+1),
          getPiece(Row, Column1, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          ))
        )
        ;
          (Column1 =:= Column - (PieceNumber+2),
          getPiece(Row, Column1, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
          )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          )
        ))).

/* Capture right for both players */

validateCaptureRightSide(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        CannonType == horizontalCannon,
        Row1 is Row,
        Column2 is Column + 4 - PieceNumber,
        getPiece(Row, Column2, Board, EmptyPiece),
        EmptyPiece == emptyCell,
        (
        (Column1 =:= Column + 5 - PieceNumber,
          getPiece(Row, Column1, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          ))
        )
        ;
          (Column1 =:= Column + 6 - PieceNumber,
          getPiece(Row, Column1, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
          )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          )
        ))).

/* Capture in North East direction for both players */

validateCaptureNE(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        CannonType == diagonalSWNECannon,
        Row2 is Row - PieceNumber,
        Column2 is Column + PieceNumber,
        getPiece(Row2, Column2, Board, EmptyPiece),
        EmptyPiece == emptyCell,
        (
        ( Column1 =:= Column + PieceNumber+1,
          Row1 =:= Row - (PieceNumber + 1),
          getPiece(Row1, Column1, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          ))
        )
        ;
          (Column1 =:= Column + PieceNumber+2,
          Row1 =:= Row - (PieceNumber + 2),
          getPiece(Row1, Column1, Board, EnemyPiece),
          (
            (Piece == blackSoldier,
            (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
            (Piece == redSoldier,
            (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
            )
          )
        )).

/* Capture in North West direction for both players */

validateCaptureNW(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        CannonType == diagonalNWSECannon,
        Row2 is Row - PieceNumber,
        Column2 is Column - PieceNumber,
        getPiece(Row2, Column2, Board, EmptyPiece),
        EmptyPiece == emptyCell,
        (
        ( Column1 =:= Column - (PieceNumber + 1),
          Row1 =:= Row - (PieceNumber + 1),
          getPiece(Row1, Column1, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          ))
        )
        ;
          (Column1 =:= Column - (PieceNumber + 2),
          Row1 =:= Row - (PieceNumber + 2),
          getPiece(Row1, Column1, Board, EnemyPiece),
          (
            (Piece == blackSoldier,
            (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
            (Piece == redSoldier,
            (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
            )
          )
        )).

/* Capture in South West direction for both players */

validateCaptureSW(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        CannonType == diagonalSWNECannon,
        Row2 is Row + (4-PieceNumber),
        Column2 is Column - (4 - PieceNumber),
        getPiece(Row2, Column2, Board, EmptyPiece),
        EmptyPiece == emptyCell,
        (
        ( Column1 =:= Column - (5 - PieceNumber),
          Row1 =:= Row + (5-PieceNumber),
          getPiece(Row1, Column1, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          ))
        )
        ;
          (Column1 =:= Column - (6 - PieceNumber),
          Row1 =:= Row + (6-PieceNumber),
          getPiece(Row1, Column1, Board, EnemyPiece),
          (
            (Piece == blackSoldier,
            (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
            (Piece == redSoldier,
            (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
            )
          )
        )).

/* Capture in South East direction for both players */

validateCaptureSE(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):-
        getPiece(Row, Column, Board, Piece),
        format('cannontype: ~w', [CannonType]),
        CannonType == diagonalNWSECannon,
        Row2 is Row + (4 - PieceNumber),
        Column2 is Column + (4 - PieceNumber),
        getPiece(Row2, Column2, Board, EmptyPiece),
        EmptyPiece == emptyCell,
        (
        ( Column1 =:= Column + (5 - PieceNumber),
          Row1 =:= Row + (5 - PieceNumber),
          getPiece(Row1, Column1, Board, EnemyPiece),
          ((Piece == blackSoldier,
          (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
          (Piece == redSoldier,
          (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
          ))
        )
        ;
          (Column1 =:= Column + (6 - PieceNumber),
          Row1 =:= Row + (6 - PieceNumber),
          getPiece(Row1, Column1, Board, EnemyPiece),
          format('test5 enemy piece ~w',[EnemyPiece]),
          (
            (Piece == blackSoldier,
            (EnemyPiece == redSoldier; EnemyPiece == redCityPiece)
            )
          ;
            (Piece == redSoldier,
            (EnemyPiece == blackSoldier; EnemyPiece == blackCityPiece)
            )
          )
        )).

/* A valid cannon capture can only be in the following ways */
validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):- validateCaptureCannonFront(Row, Column, Row1, Column1, Board, CannonType, PieceNumber).
validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):- validateCaptureCannonBack(Row, Column, Row1, Column1, Board, CannonType, PieceNumber).
validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):- validateCaptureRightSide(Row, Column, Row1, Column1, Board, CannonType, PieceNumber).
validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):- validateCaptureLeftSide(Row, Column, Row1, Column1, Board, CannonType, PieceNumber).
validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):- validateCaptureNE(Row, Column, Row1, Column1, Board, CannonType, PieceNumber).
validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):- validateCaptureNW(Row, Column, Row1, Column1, Board, CannonType, PieceNumber).
validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):- validateCaptureSE(Row, Column, Row1, Column1, Board, CannonType, PieceNumber).
validateCaptureCannon(Row, Column, Row1, Column1, Board, CannonType, PieceNumber):- validateCaptureSW(Row, Column, Row1, Column1, Board, CannonType, PieceNumber).

validateCaptureCannon(_, _, _, _, _, _, _):- write('Invalid cell to capture! Select again ..'), nl, fail.
