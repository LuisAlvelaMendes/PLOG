/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

/* Moving front for a red soldier */
move(front, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == redSoldier,
        RowToReplace is Row + 1,
        ColumnToReplace is Column,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard).

/* Moving front for a black soldier */
move(front, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == blackSoldier,
        RowToReplace is Row - 1,
        ColumnToReplace is Column,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving front left for a red soldier */
move(frontLeft, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == redSoldier,
        RowToReplace is Row + 1,
        ColumnToReplace is Column - 1,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving front left for a black soldier */
move(frontLeft, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == blackSoldier,
        RowToReplace is Row - 1,
        ColumnToReplace is Column - 1,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving front right for a red soldier */
move(frontRight, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == redSoldier,
        RowToReplace is Row + 1,
        ColumnToReplace is Column + 1,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving front right for a black soldier */
move(frontRight, Row, Column, Board, NewBoard):-  
        getPiece(Row, Column, Board, Piece),
        Piece == blackSoldier,
        RowToReplace is Row - 1,
        ColumnToReplace is Column + 1,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving actual left */
move(leftSide, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        RowToReplace is Row,
        ColumnToReplace is Column - 1,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving actual right */
move(rightSide, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        RowToReplace is Row,
        ColumnToReplace is Column + 1,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving back for a red soldier */
move(back, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == redSoldier,
        RowToReplace is Row - 2,
        ColumnToReplace is Column,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard).

/* Moving back for a black soldier */
move(back, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == blackSoldier,
        RowToReplace is Row + 2,
        ColumnToReplace is Column,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard).

/* Moving back left for a red soldier */
move(backLeft, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == redSoldier,
        RowToReplace is Row - 2,
        ColumnToReplace is Column - 2,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving back left for a black soldier */
move(backLeft, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == blackSoldier,
        RowToReplace is Row + 2,
        ColumnToReplace is Column - 2,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving back right for a red soldier */
move(backRight, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == redSoldier,
        RowToReplace is Row - 2,
        ColumnToReplace is Column + 2,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 

/* Moving back right for a black soldier */
move(backRight, Row, Column, Board, NewBoard):-
        getPiece(Row, Column, Board, Piece),
        Piece == blackSoldier,
        RowToReplace is Row + 2,
        ColumnToReplace is Column + 2,
        replaceInMatrix(Board, Row, Column, emptyCell, TempBoard),
        replaceInMatrix(TempBoard, RowToReplace, ColumnToReplace, Piece, NewBoard). 