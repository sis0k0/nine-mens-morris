public enum Color: String {
    case first = "🔴"
    case second = "🔵"
    case none = ""

    public func toString() -> String {
        return self.rawValue
    }
}