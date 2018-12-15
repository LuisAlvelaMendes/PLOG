:- use_module(library(random)).
:- use_module(library(system)).
:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('utilities.pl').

generateRandomBoard(Board, N):-
        initializeRandomSeed,
        random(4, 20, N),
        
        Size is N*N,
        length(Board, Size),
        domain(Board, 1, 2),
        
        Houses is N*2,
        count(2, Board, #=, Houses),
        
        RemainingSize is N*N - N*2,
        count(1, Board, #=, RemainingSize),
        
        labeling([], Board), !.

transformBoard([], _, []).
transformBoard(Board, N, [H|T]):-
        take(N, Board, Temp),
        H = Temp,
        trim(Board, N, LatestBoard),
        transformBoard(LatestBoard, N, T).
        

makeRandomBoard(FinalResult):-
        generateRandomBoard(Board, N),
        random_permutation(Board, ShuffledBoard),
        replace(1, emptyCell, ShuffledBoard, Temp),
        replace(2, houseCell, Temp, Result),
        transformBoard(Result, N, FinalResult).