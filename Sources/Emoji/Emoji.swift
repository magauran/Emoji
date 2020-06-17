public struct Emoji: RawRepresentable {
    public let rawValue: String
    
    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    init(_ emoji: String) {
        self.rawValue = emoji
    }
}
