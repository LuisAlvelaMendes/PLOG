:-include('boardLists.pl').

/*Carateres e a sua correspondencia com elementos na lista interna*/
getSymbol(emptyCell, ' ').
getSymbol(houseCell, 'H').

/*Imprime um daqueles carateres com barras a volta*/
printCell(Char):- write('| '), write(Char).

/*Imprime o numero da House (supondo que estao seguidos) */
printHouseNumber(Head,N, NN):- (Head == houseCell, write(N), NN is N+1) ; NN is N. 

/*Caso base: quando ja consumiu toda a linha (sublista da lista grande) so imprime uma barra final e um espaco*/
display_board_line([],N,N):- write('| ') , nl.

/*Para cada linha, ou seja, sublista, vai tentando encontrar uma correspondencia entre o elemento a analisar nesta etapa, que vai sendo a cabeca, e o charater a imprimir. Depois usa-se tail rescursion para ir passando ao proximo elemento*/
display_board_line([Head|Tail],N,NNN):- getSymbol(Head,Char), printCell(Char), printHouseNumber(Head,N,NN), display_board_line(Tail,NN,NNN).

/*Vai consumindo cada sublista da lista grande, cada linha [emptyCell, emptyCell, ...] neste caso e um "Head", vai-se usando tail recursion para chegar as outras linhas*/
display_game_aux([],_):- nl.
display_game_aux([Head|Tail],N):- display_board_line(Head,N,NN), display_game_aux(Tail,NN).

display_game(Board):- display_game_aux(Board,1).

/*Imprime o numero da House (supondo que estao seguidos) */
printHouseNumber2(_,_, _).

/*Caso base: quando ja consumiu toda a linha (sublista da lista grande) so imprime uma barra final e um espaco*/
display_board_line2([],N,N):- write('| ') , nl.

/*Para cada linha, ou seja, sublista, vai tentando encontrar uma correspondencia entre o elemento a analisar nesta etapa, que vai sendo a cabeca, e o charater a imprimir. Depois usa-se tail rescursion para ir passando ao proximo elemento*/
display_board_line2([Head|Tail],N,NNN):- getSymbol(Head,Char), printCell(Char), printHouseNumber2(Head,N,NN), display_board_line2(Tail,NN,NNN).

/*Vai consumindo cada sublista da lista grande, cada linha [emptyCell, emptyCell, ...] neste caso e um "Head", vai-se usando tail recursion para chegar as outras linhas*/
display_game_aux2([],_):- nl.
display_game_aux2([Head|Tail],N):- display_board_line2(Head,N,NN), display_game_aux2(Tail,NN).

display_game2(Board):- display_game_aux2(Board,1).

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
