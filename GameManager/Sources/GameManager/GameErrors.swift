public struct GameErrors {
    public static let invalidCoordinates = "Error: The provided coordinates are invalid!"
    public static let positionEmpty = "Error: The provided position is empty!"
    public static let positionNotEmpty = "Error: The provided position is already taken!"
    public static let moveOpponentPiece = "Error: Can't move opponent's piece!"
    public static let nonNeighborMove = "Error: Cannot move to a non-neighbor position!"
    public static let removeOwnPiece = "Error: Cannot remove your own piece!"
    public static let removeFromMill = "Error: Cannot remove piece that's part of a mill!"
    public static let invalidMoveCommand = "Error: The command must in the following format: 'A1A4'!"
}
