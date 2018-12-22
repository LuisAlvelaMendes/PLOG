:- use_module(library(random)).

% adds random seed
initializeRandomSeed:-
        now(Usec), Seed is Usec mod 30269,
        getrand(random(X, Y, Z, _)),
        setrand(random(Seed, X, Y, Z)), !.

% copies N elements from a list
take(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).

% trims a list
trim(L,N,S) :- length(P,N), append(P,S,L).

% divide in two lists
div(L,A,B):-
		append(A,B,L),
		length(A,N),
		length(B,N).

% replaces a specific element for another in a matrix (taken from last project)
replaceInList([_H|T], 0, Value, [Value|T]).
replaceInList([H|T], Index, Value, [H|TNew]) :-
        Index > 0,
        Index1 is Index - 1,
        replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
        replaceInList(H, Column, Value, HNew).

replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
        Row > 0,
        Row1 is Row - 1,
        replaceInMatrix(T, Row1, Column, Value, TNew).

matrix(Matrix, I, J, Value) :-
    nth0(J, Matrix, Row),
    nth0(I, Row, Value).

% fill a list with a value
fill([], _, 0).
fill([X|Xs], X, N) :- N0 is N-1, fill(Xs, X, N0).

% make pairs of coordinates with two lists
makeCoordPairs([], [], []).
makeCoordPairs([X|Tx], [Y|Ty], [Result|Tr]):-
        Result = [X, Y],
        makeCoordPairs(Tx, Ty, Tr).

% make sure a pair of coordinates is unique
dif_all([]).
dif_all([H|T]) :-
    maplist(dif(H),T),
    dif_all(T).

% flatten list
flatten2([], []) :- !.
flatten2([L|Ls], FlatL) :-
    !,
    flatten2(L, NewL),
    flatten2(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten2(L, [L]).

% generate two distinct random numbers
gen(N,X) :-
 random(1, N, X).
gen(N,X) :-  % the make it backtrack bit...
 !,gen(N,X).
 
gen_2_num(N,X,Y) :-
 gen(N,X),
 gen(N,Y),
 \+ X = Y, !.
