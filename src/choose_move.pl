/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

/* choosing an action presuming bot has nearby enemies he will either capture or retreat, else, he will move */
choose_action_computer(Board, NewBoard, Player, BotType):-
        Player == red,
        nl,
        write('1'), nl,
        findall([MRow,MColumn],matrixred(Board, MColumn, MRow),RedPieces),
        length(RedPieces,Len),
        write('2'), nl,
        random(0,Len,N),
        nth0(N, RedPieces, Coords),
        write('3'), nl,
        main_action_logic(Coords, Board, NewBoard, Player, BotType).

choose_action_computer(Board, NewBoard, Player, BotType):-
        Player == black,
        nl,
        findall([MRow,MColumn],matrixblack(Board, MColumn, MRow), BlackPieces),
        length(BlackPieces,Len),
        random(0,Len,N),
        nth0(N, BlackPieces, Coords),
        main_action_logic(Coords, Board, NewBoard, Player, BotType).

main_action_logic(Coords, Board, NewBoard, _, BotType):-
        nth0(0, Coords, Row),
        nth0(1, Coords, Column),
        BotType == agressive,
        checkComputerNearbyEnemies(Row, Column, Board),
        choose_to_capture(Row, Column, Board, NewBoard). 

main_action_logic(Coords, Board, NewBoard, _, BotType):-
        nth0(0, Coords, Row),
        nth0(1, Coords, Column),
        BotType == agressive,
        checkComputerNearbyEnemies(Row, Column, Board),
        choose_to_retreat(Row, Column, Board, NewBoard). 

main_action_logic(Coords, Board, NewBoard, _, BotType):-
        nth0(0, Coords, Row),
        nth0(1, Coords, Column),
        BotType == agressive,
        checkComputerNearbyEnemies(Row, Column, Board),
        choose_to_move_computer(Row, Column, Board, NewBoard).

main_action_logic(Coords, Board, NewBoard, _, BotType):-
        nth0(0, Coords, Row),
        nth0(1, Coords, Column),
        BotType == easy,
        checkComputerNearbyEnemies(Row, Column, Board),
        choose_to_retreat(Row, Column, Board, NewBoard),
        write('one'), nl. 

main_action_logic(Coords, Board, NewBoard, _, BotType):-
        nth0(0, Coords, Row),
        nth0(1, Coords, Column),
        BotType == easy,
        checkComputerNearbyEnemies(Row, Column, Board),
        choose_to_capture(Row, Column, Board, NewBoard),
        write('two'), nl. 

main_action_logic(Coords, Board, NewBoard, _, BotType):-
        nth0(0, Coords, Row),
        nth0(1, Coords, Column),
        BotType == easy,
        write('why cant you move?'), nl,
        choose_to_move_computer(Row, Column, Board, NewBoard),
        write('three'), nl. 

/* capture*/
choose_to_capture(Row1, Column1, Board, NewBoard):-
        write('entered capture'), nl,
        findall([Position], validateComputerCapture(Row1, Column1, _, _, Board, Position), Positions),
        length(Positions,LenPositions),
        random(0,LenPositions,M),
        nth0(M, Positions, Pos),
        nth0(0, Pos, Position),
        move(Position, Row1, Column1, Board, NewBoard).

/* retreat */
choose_to_retreat(Row1, Column1, Board, NewBoard):-
        write('entered retreat'), nl, 
        findall([CurrentMove], validateComputerRetreat(Row1, Column1, _, _, Board, CurrentMove), Moves),
        length(Moves,LenMoves),
        random(0,LenMoves,M),
        nth0(M, Moves, Move),
        nth0(0, Move, CurrentMove),
        move(CurrentMove, Row1, Column1, Board, NewBoard).

/* move normally */
choose_to_move_computer(Row1, Column1, Board, NewBoard):-
        format("~w:~w", [Row1, Column1]), nl,
        findall([CurrentMove], validateComputerMove(Row1, Column1, _, _, Board, CurrentMove), Moves),
        length(Moves,LenMoves),
        random(0,LenMoves,M),
        nth0(M, Moves, Move),
        nth0(0, Move, CurrentMove),
        move(CurrentMove, Row1, Column1, Board, NewBoard).

/* move cannon */
choose_to_move_cannon(Row1, Column1, Board, NewBoard):-
        format("~w:~w", [Row1, Column1]), nl,
        checkPieceInCannonComputer(Row1, Column1, Board, _, CannonType, PieceNumber),
        findall([CurrentMove], validateComputerMoveCannon(Row1, Column1, Row1, Column1, Board, CannonType, PieceNumber, CurrentMove), Moves),
        length(Moves,LenMoves),
        random(0,LenMoves,M),
        nth0(M, Moves, Move),
        nth0(0, Move, CurrentMove),
        move_cannon(CurrentMove, Row1, Column1, Board, NewBoard, CannonType, PieceNumber).
