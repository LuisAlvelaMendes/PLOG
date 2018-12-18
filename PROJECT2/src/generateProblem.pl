:- use_module(library(random)).
:- use_module(library(system)).
:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('utilities.pl').

findCoords(_, _, [], _, _).
findCoords([X1,X2|Xs], [Y1,Y2|Ys], [L|T], L1, L2):-
       
        L #= ((X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2)),
        
        list_to_fdset([L1, L2], FD),
        
        L in_set FD,
        
        findCoords(Xs, Ys, T, L1, L2).

generateRandomBoard(Board, N, HouseCoordsX, HouseCoordsY):-
        initializeRandomSeed,
        random(4, 10, N),
        
        Size is N*N,
        fill(Board, 1, Size),
        
        MaxDistance is (N*N + N*N),
        
        %gerar duas distâncias aleatórias e posicionar as casas em relação às distâncias
        random(1, MaxDistance, L1),
        random(1, MaxDistance, L2),
        
        L1 #\= L2,
        
        %obter as coordenadas de cada casa e fornecer isso ao solve
        
        SuperiorLimit is N-1,
        Houses is N*2,
        
        length(HouseCoordsX, Houses),
        length(HouseCoordsY, Houses),
        
        domain(HouseCoordsX, 0, SuperiorLimit),
        domain(HouseCoordsY, 0, SuperiorLimit),

        findCoords(HouseCoordsX, HouseCoordsY, Lengths, L1, L2),
        
        write('here'), nl,
        
        nvalue(2, Lengths),
        
        write('after nvalue'), nl,
        
        append(HouseCoordsX, HouseCoordsY, Coords),
        
        write(Coords), nl,
        
        labeling([], Coords),
        
        write('here again').

transformBoard([], _, []).
transformBoard(Board, N, [H|T]):-
        take(N, Board, Temp),
        H = Temp,
        trim(Board, N, LatestBoard),
        transformBoard(LatestBoard, N, T).

makeRandomBoard(FinalResult, N, HouseCoordsX, HouseCoordsY):-
        generateRandomBoard(Board, N, HouseCoordsX, HouseCoordsY),
        replace(1, emptyCell, Board, Temp),
        transformBoard(Temp, N, FinalResult).
        %predicate to replace emptyCells with coords