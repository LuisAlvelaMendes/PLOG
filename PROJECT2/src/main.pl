:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

% We need to know if the board is a 4x4 or a 5x5 etc ..
getBoardSize([Head|_], N):-
        length(Head, N).

% Gets a coordinate (I, J) based on value
matrix(Matrix, I, J, Value) :-
    nth0(J, Matrix, Row),
    nth0(I, Row, Value).

solveBoard(Board, H, Result):-
        getBoardSize(Board, N),
        
        % The maximum length would be the diagonal of the square "board"
        MaxLength is (N*N + N*N),
        Lengths = [L1, L2], domain(Lengths, 1, MaxLength),
        
        % There can only be two possible lengths for connecting houses and they are distinct
        all_distinct(Lengths),

        % A board NxN can not have more than N*2 houses
        H #=< N*2,
        
        % The number of houses must be even
        H mod 2 #= 0,
        
        % There is a maximum of N connections
        ResultLength #=< N,
        length(Result, ResultLength),
        
        % Houses cannot be a part of more than 1 connection
        % por ex: connected(H1, H2, L1) => connected(X, Y, <any length>) X \= H1 e Y \= H2, já não pode aparecer mais
       /* nvalue pode não ser o mais correto a utilizar aqui --> */ nvalue(ResultLength, [H1, H2, L]), 
        
        H1 #= H2, 
        matrix(Board, X1, Y1, H1),
        matrix(Board, X2, Y2, H2),
        
        L = ((X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2)),
        element(Pos, Lengths, L),
        (Pos #= 1 #\/ Pos #=2), 
        
        % There cannot be a pair of houses without a connection

        labeling([], Result),
        nl.