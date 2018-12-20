:-include('boardLists.pl').

/*Carateres e a sua correspondencia com elementos na lista interna*/
getSymbol(emptyCell, ' ').
getSymbol(houseCell, 'H').

/*Imprime um daqueles carateres com barras a volta*/
printCell(Char):- write('| '), write(Char), write(' ').

/*Imprime o numero da House (supondo que estao seguidos) */
printHouseNumber(Head,N,NN):- (Head == houseCell, write(N), NN is N+1) ; NN is N.

/*Caso base: quando ja consumiu toda a linha (sublista da lista grande) so imprime uma barra final e um espaco*/
display_board_line([],N,N):- write('| ') , nl.

/*Para cada linha, ou seja, sublista, vai tentando encontrar uma correspondencia entre o elemento a analisar nesta etapa, que vai sendo a cabeca, e o charater a imprimir. Depois usa-se tail rescursion para ir passando ao proximo elemento*/
display_board_line([Head|Tail],N,NNN):- getSymbol(Head,Char), printCell(Char), printHouseNumber(Head,N,NN), display_board_line(Tail,NN,NNN).

/*Vai consumindo cada sublista da lista grande, cada linha [emptyCell, emptyCell, ...] neste caso e um "Head", vai-se usando tail recursion para chegar as outras linhas*/
display_game_aux([],_):- nl.
display_game_aux([Head|Tail],N):- display_board_line(Head,N,NN), display_game_aux(Tail,NN).

display_game(Board):- display_game_aux(Board,1).

displaySolution(Pairs, Lengths):-
        div(Pairs,A,B),
        goThroughPairs(A,B,Lengths).

goThroughPairs([],[],[]).
goThroughPairs([HA|TA],[HB|TB], [LH|LT]):-
        format('Pair ~w - ~w Length: ~w~n', [HA,HB, LH]),
        goThroughPairs(TA,TB, LT).