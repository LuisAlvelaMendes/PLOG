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

% replaces all occurences of an element for another
replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- H \= O, replace(O, R, T, T2).

matrix(Matrix, I, J, Value) :-
    nth0(J, Matrix, Row),
    nth0(I, Row, Value).
