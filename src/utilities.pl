/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

/* necessary functions for getting user inputs */
getChar(Input):-
        get_char(Input),
        get_char(_), !.

getInt(Input):-
        get_code(TempInput),
        Input is TempInput - 48,
        get_code(_), !.

/* Asks user for which Piece he intends to move, each has to be converted to an index */
askCoords(Row, Column):-
        repeat,
        write('Column:'),
        getChar(ColumnUserSelected),
        columnIndex(ColumnUserSelected, Column),
        write('Row:'),
        getChar(RowUserSelected),
        rowIndex(RowUserSelected, Row).

/* converting a column to an integer index so we can find it in our list[row][column] */
columnIndex('A', 0).
columnIndex('B', 1).
columnIndex('C', 2).
columnIndex('D', 3).
columnIndex('E', 4).
columnIndex('F', 5).
columnIndex('G', 6).
columnIndex('H', 7).
columnIndex('I', 8).
columnIndex('J', 9).

/* doing the same for the row */
rowIndex('1', 9).
rowIndex('2', 8).
rowIndex('3', 7).
rowIndex('4', 6).
rowIndex('5', 5).
rowIndex('6', 4).
rowIndex('7', 3).
rowIndex('8', 2).
rowIndex('9', 1).
rowIndex('10', 0).

/* getting the Piece of index [row][col] from the list */

/* first, you must iterate through all rows (sublists of the biggest list) */
getPiece(0, Column, [Head |_], Piece):- iterateColumn(Column, Head, Piece).
getPiece(Row, Column, [_| Tail], Piece):-
        Row > 0,
        NextRow is Row - 1,
        getPiece(NextRow, Column, Tail, Piece), !.

/* then, iterate inside each sublist, go through all columns */
iterateColumn(0, [Head |_], Head):- !.
iterateColumn(Column, [_| Tail], Piece):-
        Column > 0,
        NextColumn is Column - 1,
        iterateColumn(NextColumn, Tail, Piece).