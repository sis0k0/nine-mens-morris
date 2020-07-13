public enum Color: String {
    case first = "*"
    case second = "o"
    case none = ""

    public func toString() -> String {
        return self.rawValue
    }
}