import Player

protocol Position {
    var coordinates: String {get set}
    var neighbors: [String] {get set}
    var isEmpty: Bool {get set}
    var piece: Piece? {get set}

    func toString() -> String
    func setPlayer(piece: Piece) -> Void
    func removePlayer() -> Void
}

public class BoardPosition: Position {
    public var neighbors: [String] = []
    public var coordinates: String
    public var positionLineNeighbours: [[String]] = []
    public var isEmpty = true
    public var piece: Piece?

    public init(_ coordinates: String, _ neighbors: [String], _ lines: [[String]]){
        self.neighbors = neighbors
        self.coordinates = coordinates
        self.positionLineNeighbours = lines
    }

    init(coordinates: String){
        self.coordinates = coordinates
    }

    public func setPlayer(piece: Piece){
        self.piece = piece
        self.isEmpty = false
    }

    public func removePlayer(){
        self.piece = nil
        self.isEmpty = true
    }

    func toString() -> String {
        guard let Piece = self.piece else {
            return "⚪"
        }

        return Piece.color.toString()
    }
}