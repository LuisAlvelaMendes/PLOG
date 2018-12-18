:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('display.pl').
:- include('generateProblem.pl').
:- include('utilities.pl').

% We need to know if the board is a 4x4 or a 5x5 etc ..
getBoardSize([Head|_], N):-
        length(Head, N).

goThroughHouses([], [], _, _, []).
goThroughHouses([H1|Hs1], [H2|Hs2], HouseCoordsX, HouseCoordsY, [L|Ls]):-
        
        element(H1, HouseCoordsX, X1),
        element(H1, HouseCoordsY, Y1),
        element(H2, HouseCoordsX, X2),
        element(H2, HouseCoordsY, Y2),

        H1 #> H2,            
       
        L #= ((X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2)),
        
        goThroughHouses(Hs1, Hs2, HouseCoordsX, HouseCoordsY, Ls).
        
solveBoard(Board, H, HouseCoordsX, HouseCoordsY, Result, Lengths):-
        getBoardSize(Board, N),

        % A board NxN can not have more than N*2 houses
        H #=< N*2,
        
        % The number of houses must be even
        H mod 2 #= 0,
        
        Half is H//2, 
        
        % connect each half of houses through two lists in which elements represent the house number
        % elements in the same index of each list are paired together
        length(HousePair1, Half), domain(HousePair1, 1, H),
        length(HousePair2, Half), domain(HousePair2, 1, H),
        append(HousePair1, HousePair2, HouseList),
        all_distinct(HouseList),
        
        % All houses must be connected to some other house, but only one-to-one
        % Go through houses and find lengths, there must be H/2 lengths
        goThroughHouses(HousePair1, HousePair2, HouseCoordsX, HouseCoordsY, Lengths),

        % there can only be 2 distinct lenghts
        nvalue(2, Lengths),
        
        append(HousePair1, HousePair2, Result),
        
        labeling([ffc], Result).


displaySolution(Pairs, Lengths):-
        div(Pairs,A,B),
        goThroughPairs(A,B,Lengths).

goThroughPairs([],[],[]).
goThroughPairs([HA|TA],[HB|TB], [LH|LT]):-
        format('Pair ~w - ~w Length: ~w~n',[HA,HB, LH]),
        goThroughPairs(TA,TB, LT).

% puzzle "0" is actually a random auto-generated puzzle
play(Puzzle, Pairs, Lengths):-
        Puzzle == 0,
        makeRandomBoard(Board, N, HouseCoordsX, HouseCoordsY),
        Houses is N*2,
        display_game(Board).

/*
        findall(X, matrix(Board, X, _, houseCell), Xlist),
        findall(Y, matrix(Board, _, Y, houseCell), Ylist),

        length(Xlist,XL),
        HXL is XL//2,
        trim(Xlist,HXL,XFinalList),

        length(Ylist,YL),
        HYL is YL//2,
        trim(Ylist,HYL,YFinalList),

        format('~nlist X: ~w ~n',[XFinalList]),
        format('~nlist Y: ~w ~n',[YFinalList]),
        solveBoard(Board, Houses, XFinalList, YFinalList, Pairs, Lengths),
        format('~nP: ~w ~n',[Pairs]),
        format('~nL: ~w ~n~n',[Lengths]),
        displaySolution(Pairs,Lengths).
*/

% hardcoded puzzles
play(Puzzle, Pairs, Lengths):-
        Puzzle == 1,
        board4x4(B),
        display_game(B),
        solveBoard(B, 8, [0,0,2,3,2,3,2,3], [0,3,0,0,1,1,2,3], Pairs, Lengths).

play(Puzzle, Pairs, Lengths):-
        Puzzle == 2,
        board5x5(B),
        display_game(B),
        solveBoard(B, 10, [3,4,0,4,0,1,2,4,0,4], [0,0,1,1,2,2,3,3,4,4], Pairs, Lengths).