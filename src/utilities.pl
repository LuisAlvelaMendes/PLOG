/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

/* Asks user for which Piece he intends to move, each has to be converted to an index */
/* TODO: use name/2 to make it so you only input 1 line like: cell E2 */
checkEmptyPossibleTail([]).
parseCoordsList([Column | [Row | PossibleTail ] ], ColumnUserSelected, RowUserSelected):- checkEmptyPossibleTail(PossibleTail), atom_codes(ColumnUserSelected, [Column]), number_codes(RowUserSelected, [Row]).
parseCoordsList([Column | [_ | [PossibleTail | [] ] ] ], ColumnUserSelected, RowUserSelected):- write('suposto'), nl, number_codes(Temp, [PossibleTail]), Temp is 0, atom_codes(ColumnUserSelected, [Column]), RowUserSelected = 10.
parseCoordsList(_, _, _):- write("Invalid coords."), nl, fail.

askCoords(Row, Column):-
        repeat,
        write('Coordinates (Lowercase Column followed by Row): '),
        read(FullCoords),
        atom_codes(FullCoords, CoordsList),
        parseCoordsList(CoordsList, ColumnUserSelected, RowUserSelected),
        columnIndex(ColumnUserSelected, Column),
        Row is 10 - RowUserSelected, !.

askColumn(Column):-
        repeat,
        write('Column  '),
        read(ColumnUserSelected),
        columnIndex(ColumnUserSelected, Column).

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

/* replacing elements in the board, when moving for example replacing redSoldier with emptyCell and destination emptyCell with redSoldier */
replaceInList([_H|T], 0, Value, [Value|T]).
replaceInList([H|T], Index, Value, [H|TNew]) :-
        Index > 0,
        Index1 is Index - 1,
        replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
        replaceInList(H, Column, Value, HNew).

replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
        Row > 0,
        Row1 is Row - 1,
        replaceInMatrix(T, Row1, Column, Value, TNew).