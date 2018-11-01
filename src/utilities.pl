/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

/* Asks user for which Piece he intends to move, each has to be converted to an index */
askCoords(Row, Column):-
        repeat,
        write('Column (in miniscule letters!) '),
        read(ColumnUserSelected),
        columnIndex(ColumnUserSelected, Column),
        write('Row '),
        read(RowUserSelected),
        Row is 10 - RowUserSelected.

/* converting a column to an integer index so we can find it in our list[row][column] */
columnIndex(a, 0).
columnIndex(b, 1).
columnIndex(c, 2).
columnIndex(d, 3).
columnIndex(e, 4).
columnIndex(f, 5).
columnIndex(g, 6).
columnIndex(h, 7).
columnIndex(i, 8).
columnIndex(j, 9).

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