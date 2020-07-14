import Board
import Player

protocol Manager {
    var RedPlayer: Player {get}
    var BluePlayer: Player {get}
    var Board: GameBoard {get}
}

public class GameManager {
    var RedPlayer: Player = Player("Player \(Color.red)", Color.red)
    var BluePlayer: Player = Player("Player \(Color.blue)", Color.blue)
    var Board: GameBoard = GameBoard()

    public var activePlayer: Player
    public var notActivePlayer: Player

    public init(){
        self.activePlayer = self.RedPlayer
        self.notActivePlayer = self.BluePlayer
    }

    public func swapActivePlayer() {
        let tempPlayer = activePlayer;
        self.activePlayer = self.notActivePlayer
        self.notActivePlayer = tempPlayer
    }

    public func setPiece(coordinates: String) -> Bool {
        if !self.Board.isFieldEmpty(coordinates: coordinates) {
            return false
        }

        let newPiece = Piece(coordinates, self.activePlayer.color)

        if let position = self.Board.positions[coordinates] {
            position.setPlayer(piece: newPiece)
            self.activePlayer.addPiece(piece: newPiece)
            return true
        }

        return false
    }

    public func movePiece(from:String, to: String, canFly: Bool = false) -> String {
        guard let position = self.Board.positions[from] else {
            return GameErrors.invalidCoordinates
        }

        guard let destPosition = self.Board.positions[to] else {
            return GameErrors.invalidCoordinates
        } 

        guard var positionPiece = position.piece else {
            return GameErrors.positionEmpty
        }

        if positionPiece.color != self.activePlayer.color {
            return GameErrors.moveOpponentPiece
        }

        if !canFly && (!position.positionLineNeighbours.contains{ tripple in 
            return tripple.contains(to)
            }) {
            return GameErrors.nonNeighborMove
        }

        if !destPosition.isEmpty {
            return GameErrors.positionNotEmpty
        }

        let movePieceRes = self.activePlayer.movePiece(from: from, to: to)
        if movePieceRes != "" {return movePieceRes}

        positionPiece.coordinates = to
        position.removePlayer()
        destPosition.setPlayer(piece: positionPiece)

        return ""
    }

    public func removePiece(coordinates: String) -> String {
        guard let position = self.Board.positions[coordinates] else {
            return GameErrors.invalidCoordinates
        }

        guard let positionPiece = position.piece else {
            return GameErrors.positionEmpty
        }

        if !validateNoMill(coordinates: coordinates) {
            return GameErrors.removeFromMill
        }

        if (positionPiece.color == activePlayer.color) {
            return GameErrors.removeOwnPiece
        }

        let removePieceRes = self.notActivePlayer.removePiece(coordinates: positionPiece.coordinates)
        if removePieceRes != "" {return removePieceRes}

        position.removePlayer() 

        return ""
    }

    public func validateNoMill(coordinates: String) -> Bool {
        if (!noneMillsFormed(pieces: self.notActivePlayer.pieces, color: self.notActivePlayer.color)) {
            return true
        }

        if (isMillFormed(coordinates: coordinates, color: self.notActivePlayer.color)) {
            return false
        }

        return true
    }

    public func noneMillsFormed(pieces: [Piece], color: Color) -> Bool {
        for piece in pieces {
            if (!isMillFormed(coordinates: piece.coordinates, color: color)) {
                return true
            }
        }

        return false
    }

    public func isMillFormed(coordinates: String, color: Color) -> Bool {
        guard let position = self.Board.positions[coordinates] else {
            return false
        }

        if isMillIn(tripples: position.positionLineNeighbours, color: color) {
            return true
        }

        return false
    }

    func isMillIn(tripples: [[String]], color: Color) -> Bool {
        for tripple in tripples {
            if(isTrippleMillFormed(tripple: tripple){
                $0.rawValue == color.rawValue
            }){
                return true
            }
        }

        return false
    }

    func isTrippleMillNotFormed(tripple: [String], isColorSame: (Color)->Bool) -> Bool{
        for positionPosition in tripple {
            guard let position = self.Board.positions[positionPosition] else {
                continue
            }

            guard let piece = position.piece else{
                continue
            }

            if isColorSame(piece.color) && !isMillIn(tripples: position.positionLineNeighbours, color: piece.color) {
                return true
            }
        }

        return false
    }

    func isTrippleMillFormed(tripple: [String], isColorSame: (Color)->Bool) -> Bool {
        for positionPosition in tripple {
            guard let position = self.Board.positions[positionPosition] else {
                return false
            }

            guard let piece = position.piece else{
                return false
            }

            if !isColorSame(piece.color) {return false}
        }

        return true
    }

    public func visualize(){
        self.Board.visualize()
    }

    public func getPiecesCount(_ playerColor: Color) -> Int {
        switch playerColor {
            case self.RedPlayer.color:
                return self.RedPlayer.placedPiecesCount
            case self.BluePlayer.color:
                return self.BluePlayer.placedPiecesCount
            default:
                return 0
        }
    }

    public func areCoordinatesValid(coordinates: String) -> Bool {
        return self.Board.areCoordinatesValid(coordinates:coordinates)
    }

    public func decrementPieces() {
        self.activePlayer.startGamePieces -= 1
    }

    public func areAllPiecesSet() -> Bool {
        return self.RedPlayer.startGamePieces <= 0 &&
            self.BluePlayer.startGamePieces <= 0
    }

    func movePositionsAreAvailable(player: Player) -> Bool {
        for piece in player.pieces {
            guard let position = self.Board.positions[piece.coordinates] else {
                return false
            }

            for neighbor in position.neighbors{
                guard let neighbourPosition = self.Board.positions[neighbor] else {
                    continue
                }

                if neighbourPosition.isEmpty {return true}
            }
        }

        return false
    }

    public func isGameOver(player: Player) -> Bool {
        if player.placedPiecesCount < 3 {
            return true
        }

        if !movePositionsAreAvailable(player: player) {
            return true
        }

        return false
    }

    public func isGameDraw() -> Bool {
        if !movePositionsAreAvailable(player: self.activePlayer) && !movePositionsAreAvailable(player: self.notActivePlayer) {
            return true
        }

        return false
    }
}