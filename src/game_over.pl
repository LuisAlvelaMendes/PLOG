/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(lists)).

/* game over occurs whenever the redCityPiece or the blackCityPiece are no longer in play, which means they were taken by the opposite Player */
game_over(Board):- lookForCityPieceInMatrix(9, 9, Board, _).

/* first, you must iterate through all rows (sublists of the biggest list) */
lookForCityPieceInMatrix(0, Column, [Head |_], Piece):- lookForCityPieceInsideList(Column, Head, Piece).
lookForCityPieceInMatrix(Row, Column, [_| Tail], Piece):-
        Row > 0,
        NextRow is Row - 1,
        lookForCityPieceInMatrix(NextRow, Column, Tail, Piece), !.

/* then, iterate inside each sublist, go through all columns */
lookForCityPieceInsideList(0, [Head |_], Head):- !.
lookForCityPieceInsideList(Column, [_| Tail], Piece):-
        Column > 0,
        NextColumn is Column - 1,
        Piece \= redCityPiece,
        iterateColumn(NextColumn, Tail, Piece).

lookForCityPieceInsideList(Column, [_| Tail], Piece):-
        Column > 0,
        NextColumn is Column - 1,
        Piece \= blackCityPiece,
        iterateColumn(NextColumn, Tail, Piece).

lookForCityPieceInsideList(_, _, _):- fail.