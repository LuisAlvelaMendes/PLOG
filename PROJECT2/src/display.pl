:-include('boardLists.pl').


getSymbol(emptyCell, ' ').
getSymbol(houseCell, 'H').


printCell(Char):- write('| '), write(Char).

printHouseNumber(Head,N, NN):- (Head == houseCell, write(N), NN is N+1) ; NN is N. 

display_board_line([],N,N):- write('| ') , nl.
display_board_line([Head|Tail],N,NNN):- getSymbol(Head,Char), printCell(Char), printHouseNumber(Head,N,NN), display_board_line(Tail,NN,NNN).
display_game_aux([],_):- nl.
display_game_aux([Head|Tail],N):- display_board_line(Head,N,NN), display_game_aux(Tail,NN).

display_game(Board):- display_game_aux(Board,1).


display_board_line2([]):- write('| ') , nl.

display_board_line2([Head|Tail]):- getSymbol(Head,Char), printCell(Char), display_board_line2(Tail).
display_game_aux2([]):- nl.
display_game_aux2([Head|Tail]):- display_board_line2(Head), display_game_aux2(Tail).

display_game2(Board):- display_game_aux2(Board).

displaySolution(Pairs, Lengths):-
        div(Pairs,A,B),
        goThroughPairs(A,B,Lengths).

goThroughPairs([],[],[]).
goThroughPairs([HA|TA],[HB|TB],  [LH|LT]):-
        format('Pair ~w - ~w Length: ~w~n', [HA,HB, LH]),
        goThroughPairs(TA,TB, LT).

displayRandomDiv(HouseCoordsX, HouseCoordsY, Pairs, Lengths):-
        div(Pairs,A,B),
        displayRandom(A,B, HouseCoordsX, HouseCoordsY, Lengths).

displayRandom([], [], _, _, []).
displayRandom([HA|TA], [HB|TB], HouseCoordsX, HouseCoordsY, [LH|LT]):-
        ActualHA is HA-1,
        ActualHB is HB-1,
        
        nth0(ActualHA, HouseCoordsX, X1),
        nth0(ActualHA, HouseCoordsY, Y1),
        nth0(ActualHB, HouseCoordsX, X2),
        nth0(ActualHB, HouseCoordsY, Y2),
        format('Pair (~w,~w) - (~w,~w) Length: ~w~n', [X1, Y1, X2, Y2, LH]),
        displayRandom(TA, TB, HouseCoordsX, HouseCoordsY, LT).
