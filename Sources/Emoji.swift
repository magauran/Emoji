public enum EmojiImageGenerator {
    public static func image(for emoji: String, size: CGFloat = 128) -> UIImage {
        let imageSize = CGSize(width: size, height: size)

        let baseFontSize: CGFloat = 256
        let baseFont = UIFont.systemFont(ofSize: baseFontSize)
        let baseTextSize = emoji.size(withAttributes: [.font: baseFont])
        let ratio = baseFontSize / max(baseTextSize.width, baseTextSize.height)

        let fontSize = ratio * size
        let font = UIFont.systemFont(ofSize: fontSize)
        let textSize = emoji.size(withAttributes: [.font: font])

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        defer { UIGraphicsEndImageContext() }

        UIColor.clear.setFill()

        let rect = CGRect(
            origin: .init(x: (size - textSize.width) / 2, y: (size - textSize.height) / 2),
            size: textSize
        )
        emoji.draw(in: rect, withAttributes: [.font : font])

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            assertionFailure()
            return UIImage()
        }

        return image
    }
}
