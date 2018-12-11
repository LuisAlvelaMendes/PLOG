/* puzzle 1:

     [houseCell1, emptyCell, houseCell3, houseCell4],
     [emptyCell, emptyCell, houseCell5, houseCell6],
     [emptyCell, emptyCell, houseCell7, emptyCell],
     [houseCell2, emptyCell, emptyCell, houseCell8]

H1:     H2:     H3:     H4:     H5:     H6:     H7:     H8:
x:0     0       2       3       2       3       3       3       [0,0,2,3,2,3,3,3]
y:0     3       0       0       1       1       2       3       [0,3,0,0,1,1,2,3]


one of the expected answers:

connected(houseCell1, houseCell2, Length1)
connected(houseCell3, houseCell6, Length2)
connected(houseCell5, houseCell4, Length2)
connected(houseCell7, houseCell8, Length2)

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

     [emptyCell, emptyCell, emptyCell, houseCell1, houseCell2],
     [houseCell4, emptyCell, emptyCell, emptyCell, houseCell3],
     [houseCell5, houseCell6, emptyCell, emptyCell, emptyCell],
     [emptyCell, emptyCell, houseCell7, emptyCell, houseCell8],
     [houseCell10, emptyCell, emptyCell, emptyCell, houseCell9]

H1:     H2:     H3:     H4:     H5:     H6:     H7:     H8:     H9:     H10:
x:3     4       4       0       0       1       2       4       4       0       [3,4,4,0,0,1,2,4,4,0]
y:0     0       1       1       2       2       3       3       4       4       [0,0,1,1,2,2,3,3,4,4]


one of the expected answers:

connected(houseCell1, houseCell9, Length1)
connected(houseCell4, houseCell2, Length1)
connected(houseCell5, houseCell3, Length1)
connected(houseCell6, houseCell7, Length2)
connected(houseCell10, houseCell8, Length1)
        
*/

board5x5([
              [emptyCell, emptyCell, emptyCell, houseCell, houseCell],
              [houseCell, emptyCell, emptyCell, emptyCell, houseCell],
              [houseCell, houseCell, emptyCell, emptyCell, emptyCell],
              [emptyCell, emptyCell, houseCell, emptyCell, houseCell],
              [houseCell, emptyCell, emptyCell, emptyCell, houseCell]
          ]).