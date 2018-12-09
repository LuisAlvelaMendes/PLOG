/* test:

     [houseCell1, emptyCell, houseCell3, houseCell4],
     [emptyCell, emptyCell, houseCell5, houseCell6],
     [emptyCell, emptyCell, houseCell7, emptyCell],
     [houseCell2, emptyCell, emptyCell, houseCell8]

expected answer:

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