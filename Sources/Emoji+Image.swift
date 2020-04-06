import UIKit

extension UIImage {
    func inset(by insets: UIEdgeInsets) -> UIImage {
        let cgSize = CGSize(
            width: self.size.width + insets.left * self.scale + insets.right * self.scale,
            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale
        )
        
        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        
        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode) else {
            assertionFailure()
            return self
        }
        
        return image
    }
    
    func background(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            assertionFailure()
            return self
        }
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        color.setFill()
        context.fill(rect)
        self.draw(in: rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode) else {
            assertionFailure()
            return self
        }
        
        return image
    }
    
    func ellipse() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            assertionFailure()
            return self
        }
        
        let rect = CGRect(origin: .zero, size: self.size)
        context.addEllipse(in: rect)
        context.clip()
        self.draw(in: rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode) else {
            assertionFailure()
            return self
        }
        
        return image
    }
}

extension Emoji {
    public final class ImageContext {
        public private(set) var image: UIImage
        
        init(image: UIImage) {
            self.image = image
        }
    }
    
    public func size(_ size: CGSize) -> ImageContext {
        let image = Self.image(for: self.rawValue, size: size.width)
        let context = ImageContext(image: image)
        return context
    }

    private static func image(for emoji: String, size: CGFloat) -> UIImage {
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: size * scale, height: size * scale)
        
        let baseFontSize: CGFloat = size
        let baseFont = UIFont.systemFont(ofSize: baseFontSize)
        let baseTextSize = emoji.size(withAttributes: [.font: baseFont])
        let ratio = baseFontSize / max(baseTextSize.width, baseTextSize.height)
        
        let fontSize = ratio * imageSize.width
        let font = UIFont.systemFont(ofSize: fontSize)
        let textSize = emoji.size(withAttributes: [.font: font])
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        UIColor.clear.setFill()
        let rect = CGRect(
            origin: .init(x: (imageSize.width - textSize.width) / 2, y: (imageSize.height - textSize.height) / 2),
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
    
    public func process(with closure: (UIImage) -> UIImage) -> Self {
        self.image = closure(self.image)
        return self
    }
}
