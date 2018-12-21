:- use_module(library(random)).
:- use_module(library(system)).
:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('utilities.pl').

findCoords([], [], _).
findCoords([X1, X2|Xs], [Y1, Y2|Ys], FD):-
        L in_set FD,
       
        L #= ((X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2)),
                
        findCoords(Xs, Ys, FD).

generateRandomHouseCoords(N, HouseCoordsX, HouseCoordsY):-
        initializeRandomSeed,
        random(4, 10, N), 
        
        write(N), nl,
        
		% Max distance is the diagonal of the square, but coordinates only go from 0 to N-1
        MaxDistance is ((N-1)*(N-1) + (N-1)*(N-1)),
        
        % generate two random distances L1 and L2, they are guaranteed to be distinct.
        gen_2_num(MaxDistance, L1, L2),
        
        write(L1), nl,
        write(L2), nl,
        
        % domain variables are our coordinates .. each coordinate only goes from 0 to N-1
        SuperiorLimit is N-1,
		
		% generating puzzles with an even number of houses always
        Houses is N*2,
		% Houses mod 2 #= 0,
        
		% HouseCoordsX holds all X coordinates, HouseCoords Y holds the Y for each house
        length(HouseCoordsX, Houses),
        length(HouseCoordsY, Houses),
        domain(HouseCoordsX, 0, SuperiorLimit),
        domain(HouseCoordsY, 0, SuperiorLimit),
        
        %group coords together in a format like [[X1, Y1], [X2, Y2] ...] to make sure each point is unique
        makeCoordPairs(HouseCoordsX, HouseCoordsY, Result),
        
        %make sure all coords are different
        dif_all(Result),
        
		% set of valid distances
        list_to_fdset([L1, L2], FD),

		% finding coordinates that satisfy that set
        findCoords(HouseCoordsX, HouseCoordsY, FD),
        
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