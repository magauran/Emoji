import UIKit
import Emoji

extension UIImage {
    func inset(by insets: UIEdgeInsets) -> UIImage {
        let rect = CGRect(origin: .zero, size: self.size).inset(by: insets)

        let format = UIGraphicsImageRendererFormat()
        format.scale = self.scale
        let renderer = UIGraphicsImageRenderer(size: self.size, format: format)

        let image = renderer.image { context in
            let origin = CGPoint(x: insets.left, y: insets.top)
            self.draw(in: rect)
        }.withRenderingMode(self.renderingMode)

        return image
    }

    func background(_ color: UIColor) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = self.scale
        let renderer = UIGraphicsImageRenderer(size: self.size, format: format)

        let image = renderer.image { context in
            let rect = CGRect(origin: .zero, size: self.size)
            color.setFill()
            context.fill(rect)
            self.draw(in: rect)
        }.withRenderingMode(self.renderingMode)

        return image
    }

    func ellipse() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = self.scale
        let renderer = UIGraphicsImageRenderer(size: self.size, format: format)

        let image = renderer.image { context in
            let rect = CGRect(origin: .zero, size: self.size)
            context.cgContext.addEllipse(in: rect)
            context.cgContext.clip()
            self.draw(in: rect)
        }.withRenderingMode(self.renderingMode)

        return image
    }

    func grayscale(_ amount: Double) -> UIImage {
        guard let currentCGImage = self.cgImage else { return self }
        let currentCIImage = CIImage(cgImage: currentCGImage)

        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(currentCIImage, forKey: "inputImage")

        filter?.setValue(CIColor(red: 0.8, green: 0.8, blue: 0.8), forKey: "inputColor")

        filter?.setValue(amount, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return self }

        let context = CIContext()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            return processedImage
        } else {
            return self
        }
    }
}

extension Emoji {
    public final class ImageContext {
        public private(set) var image: UIImage

        init(image: UIImage) {
            self.image = image
        }
    }

    /// - Parameters:
    ///   - size: Size in points.
    ///   - scale: The scale of the screen. The default value is equal to the scale of the main screen.
    public func size(_ size: CGFloat, scale: CGFloat = UIScreen.main.scale) -> ImageContext {
        let image = Self.image(for: self.rawValue, size: size, scale: scale)
        let context = ImageContext(image: image)
        return context
    }

    private static func image(for emoji: String, size: CGFloat, scale: CGFloat) -> UIImage {
        let imageSize = CGSize(width: size, height: size)
        let baseFontSize: CGFloat = size
        let baseFont = UIFont.systemFont(ofSize: baseFontSize)
        let baseTextSize = emoji.size(withAttributes: [.font: baseFont])
        let ratio = baseFontSize / max(baseTextSize.width, baseTextSize.height)

        let fontSize = ratio * imageSize.width
        let font = UIFont.systemFont(ofSize: fontSize)
        let textSize = emoji.size(withAttributes: [.font: font])

        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: imageSize, format: format)

        let image = renderer.image { context in
            let rect = CGRect(
                origin: .init(x: (imageSize.width - textSize.width) / 2, y: (imageSize.height - textSize.height) / 2),
                size: textSize
            )
            emoji.draw(with: rect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        }

        return image
    }
}

extension Emoji.ImageContext {
    public func inset(by insets: UIEdgeInsets) -> Self {
        self.image = self.image.inset(by: insets)
        return self
    }

    public func background(_ color: UIColor) -> Self {
        self.image = self.image.background(color)
        return self
    }

    public func ellipse() -> Self {
        self.image = self.image.ellipse()
        return self
    }

    public func grayscale(_ amount: Double) -> Self {
        self.image = self.image.grayscale(amount)
        return self
    }

    public func process(with closure: (UIImage) -> UIImage) -> Self {
        self.image = closure(self.image)
        return self
    }
}
