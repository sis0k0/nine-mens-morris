import Player

protocol Board {
    func visualize() -> Void
}

public class GameBoard: Board {
    public let positions: [String: BoardPosition] = [
        "A1": BoardPosition("A1", ["D1", "A4"], [["D1","G1"], ["A4","A7"]]),            //0
        "D1": BoardPosition("D1", ["A1", "G1", "D2"], [["A1","G1"], ["D2","D3"]]),         //1
        "G1": BoardPosition("G1", ["D1", "G4"], [["A1","D1"], ["G4","G7"]]),           //2
        "B2": BoardPosition("B2", ["D2", "B4"], [["D2", "F2"], ["B4","B6"]]),           //3
        "D2": BoardPosition("D2", ["D1", "B2", "F2", "D3"], [["B2", "F2"],["D1","D3"]]),      //4
        "F2": BoardPosition("F2", ["D2", "F4"], [["B2", "D2"],["F4","F6"]]),           //5
        "C3": BoardPosition("C3", ["D3", "C4"], [[ "D3", "E3"],["C4","C5"]]),           //6
        "D3": BoardPosition("D3", ["D2", "C3", "E3"], [["C3", "E3"],["D1","D2"]]),         //7
        "E3": BoardPosition("E3", ["D3", "E4"], [["C3", "D3"],["E4","E5"]]),           //8
        "A4": BoardPosition("A4", ["A1", "B4", "A7"], [["B4","C4"],["A1","A7"]]),       //9
        "B4": BoardPosition("B4", ["B2", "A4", "C4", "B6"], [["A4","C4"], ["B2","B6"]]),    //10
        "C4": BoardPosition("C4", ["C3", "B4", "C5"], [["A4","B4"],["C3","C5"]]),       //11
        "E4": BoardPosition("E4", ["E3", "F4", "E5"], [["F4","G4"], ["E3","E5"]]),       //12
        "F4": BoardPosition("F4", ["F2", "E4", "G4", "F6"], [ ["E4","G4"], ["F2","F6"]]),   //13
        "G4": BoardPosition("G4", ["G1", "F4", "G7"], [["E4","F4"], ["G1","G7"]]),       //14
        "C5": BoardPosition("C5", ["C4", "D5"], [["D5","E5"],["C3","C4"]]),          //15
        "D5": BoardPosition("D5", ["C5", "E5", "D6"], [["C5","E5"], ["D6","D7"]]),      //16
        "E5": BoardPosition("E5", ["E4", "D5"], [["C5","D5"],["E3","E4"] ]),          //17
        "B6": BoardPosition("B6", ["B4", "D6"], [["D6","F6"], ["B2","B4"]]),          //18
        "D6": BoardPosition("D6", ["D5", "B6", "F6", "D7"], [["B6","F6"], ["D5", "D7"]]),  //19
        "F6": BoardPosition("F6", ["F4", "D6"], [["B6","D6"],["F2","F4"] ]),          //20
        "A7": BoardPosition("A7", ["A4", "D7"], [ ["D7","G7"], ["A1","A4"]]),           //21
        "D7": BoardPosition("D7", ["D6", "A7", "G7"], [ ["A7","G7"],["D5","D6"]]),      //22
        "G7": BoardPosition("G7", ["G4", "D7"], [ ["A7", "D7"],["G1","G4"]]),          //23
    ]

    public init(){

    }

    public func visualize() {
        print("     A   B   C   D   E   F   G\n")
        print("1    \(positions["A1"]!.toString())-----------\(positions["D1"]!.toString())-----------\(positions["G1"]!.toString())")
        print("     |           |           |")
        print("2    |   \(positions["B2"]!.toString())-------\(positions["D2"]!.toString())-------\(positions["F2"]!.toString())   |")
        print("     |   |       |       |   |")
        print("3    |   |   \(positions["C3"]!.toString())---\(positions["D3"]!.toString())---\(positions["E3"]!.toString())   |   |")
        print("     |   |   |       |   |   |")
        print("4    \(positions["A4"]!.toString())---\(positions["B4"]!.toString())---\(positions["C4"]!.toString())       \(positions["E4"]!.toString())---\(positions["F4"]!.toString())---\(positions["G4"]!.toString())")
        print("     |   |   |       |   |   |")
        print("5    |   |   \(positions["C5"]!.toString())---\(positions["D5"]!.toString())---\(positions["E5"]!.toString())   |   |")
        print("     |   |       |       |   |")
        print("6    |   \(positions["B6"]!.toString())-------\(positions["D6"]!.toString())-------\(positions["F6"]!.toString())   |")
        print("     |           |           |")
        print("7    \(positions["A7"]!.toString())-----------\(positions["D7"]!.toString())-----------\(positions["G7"]!.toString())")
    }

    public func isFieldEmpty(coordinates:String) -> Bool{
        if let position = self.positions[coordinates]{
            return position.isEmpty
        }

        return false
    }

    public func areCoordinatesValid(coordinates: String) -> Bool{
        if self.positions[coordinates] == nil {
            return false
        }

        return true
    }
}