:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(timeout)).
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

        % eliminate simetry, halving the search space
        H1 #> H2,            
        
        % distance between two points (without square root)
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
        % Go through houses and find lengths
        goThroughHouses(HousePair1, HousePair2, HouseCoordsX, HouseCoordsY, Lengths),

        % there can only be 2 distinct lenghts
        nvalue(2, Lengths),
        
        append(HousePair1, HousePair2, Result),
        
        labeling([min], Result), !.


tryToMakeBoard(FinalResult, N, HouseCoordsX, HouseCoordsY):-
        time_out(makeRandomBoard(FinalResult, N, HouseCoordsX, HouseCoordsY), 5000, Result),
        Result == success.

tryToMakeBoard(_, _, _, _):- fail.

% puzzle "0" is actually a random auto-generated puzzle
play(Puzzle, Pairs, Lengths):-
        repeat,
        Puzzle == 0,
        tryToMakeBoard(FinalResult, N, HouseCoordsX, HouseCoordsY),
        Houses is N*2,
        display_game2(FinalResult),
        write(HouseCoordsX), nl,
        write(HouseCoordsY), nl,
        solveBoard(FinalResult, Houses, HouseCoordsX, HouseCoordsY, Pairs, Lengths),
        displayRandomDiv(HouseCoordsX, HouseCoordsY, Pairs, Lengths), !.

% hardcoded puzzles
play(Puzzle, Pairs, Lengths):-
        Puzzle == 1,
        board4x4(B),
        display_game(B),
        solveBoard(B, 8, [0,2,3,2,3,2,0,3], [0,0,0,1,1,2,3,3], Pairs, Lengths),
        displaySolution(Pairs, Lengths), !.

play(Puzzle, Pairs, Lengths):-
        Puzzle == 2,
        board5x5(B),
        display_game(B),
        solveBoard(B, 10, [3,4,0,4,0,1,2,4,0,4], [0,0,1,1,2,2,3,3,4,4], Pairs, Lengths),
        displaySolution(Pairs, Lengths), !.

play(Puzzle, Pairs, Lengths):-
        Puzzle == 3,
        board7x7(B),
        display_game(B),
        solveBoard(B, 14, [0,3,5,6,3,6,0,3,0,5,6,4,3,5], [0,0,0,0,1,1,2,2,3,3,4,5,6,6], Pairs, Lengths),
        displaySolution(Pairs, Lengths), !.   

play(Puzzle, Pairs, Lengths):-
        Puzzle == 4,
        board8x8(B),
        display_game(B),
        solveBoard(B, 16, [0,2,0,2,0,2,0,2,6,0,2,0,2,0,2,4], [0,0,1,1,2,2,3,3,3,4,4,5,5,6,6,7], Pairs, Lengths),
        displaySolution(Pairs, Lengths), !.