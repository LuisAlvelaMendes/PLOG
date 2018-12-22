/* puzzle 1:

     [houseCell_1, emptyCell, houseCell_2, houseCell_3],
     [emptyCell, emptyCell, houseCell_4, houseCell_5],
     [emptyCell, emptyCell, houseCell_6, emptyCell],
     [houseCell_7, emptyCell, emptyCell, houseCell_8]

H1:     H2:     H3:     H4:     H5:     H6:     H7:     H8:
x:0     2       3       2       3       2       0       3       [0,2,3,2,3,2,0,3]
y:0     0       0       1       1       2       3       3       [0,0,0,1,1,2,3,3]


one of the expected answers:

connected(houseCell_1, houseCell_7, Length1)
connected(houseCell_3, houseCell_4, Length2)
connected(houseCell_2, houseCell_5, Length2)
connected(houseCell_6, houseCell_8, Length2)

in list form, pairs of connected houses with a given Length:
[(H1-H2, L1), (H3-H6, L2), (H5-H4, L2), (H7-H8, L2)]
        
*/

board4x4([
                     [houseCell, emptyCell, houseCell, houseCell],
                     [emptyCell, emptyCell, houseCell, houseCell],
                     [emptyCell, emptyCell, houseCell, emptyCell],
                     [houseCell, emptyCell, emptyCell, houseCell]
           ]).


/* puzzle 2:

     [emptyCell, emptyCell, emptyCell, houseCell_1, houseCell_2],
     [houseCell_3, emptyCell, emptyCell, emptyCell, houseCell_4],
     [houseCell_5, houseCell_6, emptyCell, emptyCell, emptyCell],
     [emptyCell, emptyCell, houseCell_7, emptyCell, houseCell_8],
     [houseCell_9, emptyCell, emptyCell, emptyCell, houseCell_10]

H1:     H2:     H3:     H4:     H5:     H6:     H7:     H8:     H9:     H10:
x:3     4       0       4       0       1       2       4       0       4       [3,4,0,4,0,1,2,4,0,4]
y:0     0       1       1       2       2       3       3       4       4       [0,0,1,1,2,2,3,3,4,4]


one of the expected answers:

connected(houseCell_1, houseCell_10, Length1)
connected(houseCell_2, houseCell_3, Length1)
connected(houseCell_4, houseCell_5, Length1)
connected(houseCell_6, houseCell_7, Length2)
connected(houseCell_8, houseCell_9, Length1)
        
*/

board5x5([
              [emptyCell, emptyCell, emptyCell, houseCell, houseCell],
              [houseCell, emptyCell, emptyCell, emptyCell, houseCell],
              [houseCell, houseCell, emptyCell, emptyCell, emptyCell],
              [emptyCell, emptyCell, houseCell, emptyCell, houseCell],
              [houseCell, emptyCell, emptyCell, emptyCell, houseCell]
          ]).

/* puzzle 3:

     [houseCell_1, emptyCell, emptyCell, houseCell_2, emptyCell, houseCell_3, houseCell_4],
     [emptyCell, emptyCell, emptyCell, houseCell_5, emptyCell, emptyCell, houseCell_6],
     [houseCell_7, emptyCell, emptyCell, houseCell_8, emptyCell, emptyCell, emptyCell],
     [houseCell_9, emptyCell, emptyCell, emptyCell, emptyCell, houseCell_10, emptyCell],
     [emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, houseCell_11],
     [emptyCell, emptyCell, emptyCell, emptyCell, houseCell_12, emptyCell, emptyCell],
     [emptyCell, emptyCell, emptyCell, houseCell_13, emptyCell, houseCell_14, emptyCell]
     

H1:     H2:     H3:     H4:     H5:     H6:     H7:     H8:     H9:     H10:    H11:     H12:     H13:    H14: 
x:0     3       5       6       3       6       0       3       0       5       6        4         3       5            [0,3,5,6,3,6,0,3,0,5,6,4,3,5]
y:0     0       0       0       1       1       2       2       3       3       4        5         6       6            [0,0,0,0,1,1,2,2,3,3,4,5,6,6]                   

        
*/

board7x7([
               [houseCell, emptyCell, emptyCell, houseCell, emptyCell, houseCell, houseCell],
               [emptyCell, emptyCell, emptyCell, houseCell, emptyCell, emptyCell, houseCell],
               [houseCell, emptyCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell],
               [houseCell, emptyCell, emptyCell, emptyCell, emptyCell, houseCell, emptyCell],
               [emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, houseCell],
               [emptyCell, emptyCell, emptyCell, emptyCell, houseCell, emptyCell, emptyCell],
               [emptyCell, emptyCell, emptyCell, houseCell, emptyCell, houseCell, emptyCell]
           ]).

/* (... ) */
board8x8([
               [houseCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell], 
               [houseCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
               [houseCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
               [houseCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell, houseCell, emptyCell],
               [houseCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
               [houseCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
               [houseCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
               [emptyCell, emptyCell, emptyCell, emptyCell, houseCell, emptyCell, emptyCell, emptyCell]
           ]).

/* 

houseCoordsX: [0,2,0,2,0,2,0,2,6,0,2,0,2,0,2,4]
houseCoordsY: [0,0,1,1,2,2,3,3,3,4,4,5,5,6,6,7]

*/