protocol PlayerData {
    var pieces: [Piece] {get set}
    var color: Color {get set}
    var placedPiecesCount: Int {get set}
    var playerName: String {get set}
}

public class Player: PlayerData {
    public var pieces: [Piece] = []
    public var placedPiecesCount = 0
    public var startGamePieces = 9
    public var color: Color = Color.none
    public var playerName: String

    init(playerName: String) {
        self.playerName = playerName
    }

    public init(_ playerName: String, _ color: Color){
        self.playerName = playerName
        self.color = color
    }

    public func setPlayerColor(color: String){
        let colorEnum = Color(rawValue: color)

        switch colorEnum {
            case nil: 
                self.color = Color.none
                print("Warning: Setting \(color) to \(self.playerName) was not successful. Selecting default color instead!")
            default: self.color = colorEnum!
        }
    }

    public func setPlayerColor(color:Color){
        self.color = color
    }

    public func addPiece(piece: Piece){
        if (self.pieces.contains {currentPiece in currentPiece.coordinates == piece.coordinates}) {
            print("Warning: Won't add piece with coordinates \(piece.coordinates) because it already exists")
        }

        self.pieces.append(piece)
        increasePiecesCount()
    }

    public func increasePiecesCount(){
        self.placedPiecesCount += 1
    }

    public func decreasePiecesCount(){
        self.placedPiecesCount -= 1
    }

    public func removePiece(coordinates: String)->String{
        guard let pieceIndex = (self.pieces.firstIndex{currentPiece in currentPiece.coordinates == coordinates}) else {
            return "Warning: Piece with coordinates \(coordinates) does not exists in \(self.playerName)'s pieces!"
        }

        self.pieces.remove(at: pieceIndex)
        decreasePiecesCount()

        return ""
    }

    public func movePiece(from: String, to: String) -> String {
        guard let pieceIndex = (self.pieces.firstIndex{currentPiece in currentPiece.coordinates == from}) else {
            return "Warning: Piece with coordinates \(from) does not exists in \(self.playerName)'s pieces!"
        }

        self.pieces[pieceIndex].coordinates = to
        return ""
    }
}