:- use_module(library(random)).
:- use_module(library(system)).
:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('utilities.pl').

findCoords([], [], [], _).
findCoords([X1, X2|Xs], [Y1, Y2|Ys], [L|T], FD):-
        L in_set FD,
       
        L #= ((X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2)),
                
        findCoords(Xs, Ys, T, FD).

generateRandomHouseCoords(N, HouseCoordsX, HouseCoordsY):-
        initializeRandomSeed,
        random(4, 10, N), 
        
        write(N), nl,
        
        MaxDistance is (N*N + N*N),
        
        %gerar duas distâncias aleatórias e posicionar as casas em relação às distâncias
        gen_2_num(MaxDistance, L1, L2),
        
        write(L1), nl,
        write(L2),
        
        %obter as coordenadas de cada casa e fornecer isso ao solve
        
        SuperiorLimit is N-1,
        Houses is N*2,
        
        length(HouseCoordsX, Houses),
        length(HouseCoordsY, Houses),
        domain(HouseCoordsX, 0, SuperiorLimit),
        domain(HouseCoordsY, 0, SuperiorLimit),
        
        %group coords together
        makeCoordPairs(HouseCoordsX, HouseCoordsY, Result),
        
        %make sure all coords are different
        dif_all(Result),
        
        list_to_fdset([L1, L2], FD),

        findCoords(HouseCoordsX, HouseCoordsY, Lengths, FD),
        
        nvalue(2, Lengths),
        
        append(HouseCoordsX, HouseCoordsY, FlatResult),
        
        labeling([ffc], FlatResult), !,
        write(HouseCoordsX), nl,
        write(HouseCoordsY).

transformBoard([], _, []).
transformBoard(Board, N, [H|T]):-
        take(N, Board, Temp),
        H = Temp,
        trim(Board, N, LatestBoard),
        transformBoard(LatestBoard, N, T).

makeRandomBoard(FinalResult, N, HouseCoordsX, HouseCoordsY):-
        generateRandomHouseCoords(N, HouseCoordsX, HouseCoordsY),
        Size is N*N,
        fill(Board, emptyCell, Size),
        transformBoard(Board, N, FinalBoard).
        %predicate to replace emptyCells with coords