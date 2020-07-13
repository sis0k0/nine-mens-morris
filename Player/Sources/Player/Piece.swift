public struct Piece {
    public var coordinates: String
    public var color: Color = Color.none

    init(coordinates: String){
        self.coordinates = coordinates
    }

    public init(_ coordinates: String,_ color: Color){
        self.coordinates = coordinates
        self.color = color
    }

    mutating func setColor(color: Color){
        self.color = color
    }
}

