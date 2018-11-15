/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

/* choosing an action presuming bot has nearby enemies he will either capture or retreat, else, he will move */
choose_action_computer(Board, NewBoard, Player):-
        Player == red,
        nl,
        findall([MRow,MColumn],matrixred(Board, MColumn, MRow),RedPieces),
        length(RedPieces,Len),
        random(0,Len,N),
        nth0(N, RedPieces, Coords),
        main_action_logic(Coords, Board, NewBoard, Player), !.

choose_action_computer(Board, NewBoard, Player):-
        Player == black,
        nl,
        findall([MRow,MColumn],matrixblack(Board, MColumn, MRow), BlackPieces),
        length(BlackPieces,Len),
        random(0,Len,N),
        nth0(N, BlackPieces, Coords),
        main_action_logic(Coords, Board, NewBoard, Player), !.

main_action_logic(Coords, Board, NewBoard, _):-
        nth0(0, Coords, Row),
        nth0(1, Coords, Column),
        
        (checkComputerNearbyEnemies(Row, Column, Board) ->
         
        /* found nearby enemy */
        /* tries to retreat if possible, if not, will capture */
       
        choose_to_capture_or_retreat(Row, Column, Board, NewBoard, _)
        
        ;
         
        /* move the piece */
        choose_to_move_computer(Row, Column, Board, NewBoard, _)
        
        ).

main_action_logic(_, Board, NewBoard, Player):-
        choose_action_computer(Board, NewBoard, Player).

/* capture*/
choose_to_capture_or_retreat(Row1, Column1, Board, NewBoard, Position):-
        write('no retreat possible, capturing'), nl,
        write('entered capture'), nl,
        findall([Position], validateComputerCapture(Row1, Column1, _, _, Board, Position), Positions),
        length(Positions,LenPositions),
        random(0,LenPositions,M),
        nth0(M, Positions, Pos),
        nth0(0, Pos, Position),
        move(Position, Row1, Column1, Board, NewBoard).

/* retreat */
choose_to_capture_or_retreat(Row1, Column1, Board, NewBoard, CurrentMove):-
        write('entered retreat'), nl, 
        findall([CurrentMove], validateComputerRetreat(Row1, Column1, _, _, Board, CurrentMove), Moves),
        length(Moves,LenMoves),
        random(0,LenMoves,M),
        nth0(M, Moves, Move),
        nth0(0, Move, CurrentMove),
        move(CurrentMove, Row1, Column1, Board, NewBoard).

choose_to_move_computer(Row1, Column1, Board, NewBoard, CurrentMove):-
        findall([CurrentMove], validateComputerMove(Row1, Column1, _, _, Board, CurrentMove), Moves),
        length(Moves,LenMoves),
        random(0,LenMoves,M),
        nth0(M, Moves, Move),
        nth0(0, Move, CurrentMove),
        move(CurrentMove, Row1, Column1, Board, NewBoard).
