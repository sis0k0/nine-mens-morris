import GameManager
import Player
import Darwin

enum GamePhase {
    case ADD
    case MOVE
}

class Game {
    var gameManager: GameManager = GameManager()
    var gamePhase = GamePhase.ADD
    var millFormed = false
    var gamePaused = true

    func start(){
        print(GameMessages.startingGame)
        sleep(2)

        self.clearAndPrintOutput(
            additionalOutput: self.gameManager.activePlayer.playerName + ", Set piece:"
        )

        commandsReader(gamePhase: firstGamePhaseCommands)

        if isGameOver() {
            return
        }

        commandsReader(gamePhase: secondGamePhaseCommands)
    }

    func commandsReader(gamePhase: (_ command:String)-> Bool){
        while let input = readLine() {
            guard input != "exit" else {
                print(GameMessages.exitGame)

                exit(0)
                break
            }

            if self.gamePaused && input == "" {
                self.gamePaused = false
                if (!finishTurn(shouldChangePlayer: false) {
                    return self.gameManager.activePlayer.playerName + (self.gamePhase == GamePhase.MOVE ? ", Move piece:" : ", Set piece:")
                }) {
                    return
                }

                continue
            }

            if self.millFormed {
                let removePieceResult = self.gameManager.removePiece(coordinates: input)

                if removePieceResult != "" {
                    if (!finishTurn(shouldChangePlayer: false){
                        "\(removePieceResult)\n\(self.gameManager.activePlayer.playerName) has set three pieces in one line. Remove opponent piece with color \(self.gameManager.notActivePlayer.color.rawValue)! "
                        }) {return}
                    continue
                }

                self.millFormed = false

                if !(finishTurn{
                    return self.gameManager.activePlayer.playerName + (self.gamePhase == GamePhase.MOVE ? ", Move piece:" : ", Set piece:")
                }) {
                    return
                }

                continue
            }

            if !gamePhase(input) {
                return
            }
        }
    }

    // Set pieces on the board
    func firstGamePhaseCommands(command:String) -> Bool{
        let parseRes = parse(command: command)

        if parseRes != "" {
            return finishTurn(shouldChangePlayer: false) {
                "\(parseRes)\n" + self.gameManager.activePlayer.playerName + ", Set piece:"
            } 
        }

        self.gameManager.decrementPieces()

        if self.gameManager.isMillFormed(coordinates: command, color: self.gameManager.activePlayer.color){
            self.millFormed = true

            return finishTurn(shouldChangePlayer: false){
                "\(self.gameManager.activePlayer.playerName) has set three pieces in one line. Remove opponent piece with color \(self.gameManager.notActivePlayer.color.rawValue): "
            }
        }

        return finishTurn {
            self.gameManager.activePlayer.playerName + ", Set piece:"
        }
    }

    // Move pieces to form mills
    func secondGamePhaseCommands(command:String) -> Bool{
        let parseRes = parse(command: command)

        if parseRes != "" {
            return finishTurn(shouldChangePlayer: false) {
                "\(parseRes)\n"+self.gameManager.activePlayer.playerName + ", Move piece:"
            } 
        }

        let to =  String(command.suffix(2))

        if self.gameManager.isMillFormed(coordinates: to, color: self.gameManager.activePlayer.color) {
            self.millFormed = true

            return finishTurn(shouldChangePlayer: false){
                "\(self.gameManager.activePlayer.playerName) has set three pieces in one line. Remove opponent piece with color \(self.gameManager.notActivePlayer.color.rawValue): "
            }
        }

        return finishTurn {
            self.gameManager.activePlayer.playerName + ", Move piece:"
        }
    }

    func finishTurn(shouldChangePlayer: Bool = true, infoMessage: () -> String = {""}) -> Bool {
        if shouldChangePlayer {self.gameManager.swapActivePlayer()}

        if self.gamePhase == GamePhase.ADD && self.gameManager.areAllPiecesSet()  {
            self.gamePhase = GamePhase.MOVE
            clearAndPrintOutput(additionalOutput: infoMessage())

            return false
        }

        clearAndPrintOutput(additionalOutput: infoMessage())

        if self.gamePhase == GamePhase.MOVE && isGameOver() {
            return false
        }

        return true
    }

    func isGameOver() -> Bool {
        if self.gameManager.isGameOver(player: self.gameManager.activePlayer) {
            print(GameMessages.gameOver)
            print("Winner: \(self.gameManager.notActivePlayer.playerName)")
            return true
        }

        if self.gameManager.isGameDraw() {
            print(GameMessages.draw)
            return true
        }

        return false
    }

    func parse(command: String) -> String {
        switch self.gamePhase {
        case .ADD:
            return parsePhaseOne(command: command)
        case .MOVE:
            return parsePhaseTwoCommand(command: command)
        }
    }

    func parsePhaseOne(command: String) -> String {
        if !self.gameManager.areCoordinatesValid(coordinates: command) {
            return GameErrors.invalidCoordinates
        }

        if !self.gameManager.setPiece(coordinates: command){
            return GameErrors.positionNotEmpty
        }

        return ""
    }

    func parsePhaseTwoCommand(command: String) -> String {
        if command.count != 4 {
            return GameErrors.invalidMoveCommand
        }

        let from = String(command.prefix(2))
        let to =  String(command.suffix(2))

        if !self.gameManager.areCoordinatesValid(coordinates: from) {
            return GameErrors.invalidCoordinates
        }

        if !self.gameManager.areCoordinatesValid(coordinates: to) {
            return GameErrors.invalidCoordinates
        }

        let canFly = self.gameManager.activePlayer.placedPiecesCount == 3

        return self.gameManager.movePiece(from: from, to: to, canFly: canFly)
    }

    func clearAndPrintOutput(additionalOutput: String  = "") {
        self.gameManager.visualize()
        let phaseMessage = self.gamePhase == GamePhase.ADD ?
            GameMessages.setPieces :
            GameMessages.movePieces 

        print("""
            \n\(phaseMessage).
            🔴 pieces on board: \(self.gameManager.getPiecesCount(Color.red))
            🔵 pieces on board: \(self.gameManager.getPiecesCount(Color.blue))
            \n------------------------------------------------------------------------
            \(additionalOutput)
            """)
    }
}
