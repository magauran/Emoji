# Collection of useful libraries for working with Emoji

## Emoji

A full collection of all emojis available in iOS.

Emojis are retrieved from [gemoji](https://github.com/github/gemoji) repository.
It makes sense to use a more up-to-date source.

### How to use?

```swift
import Emoji

let emoji = Emoji.violin // 🎻
```

### TODO:

1. Support `ExpressibleByStringLiteral`
2. Add category, aliases and tags for all emojis.
3. List of all emojis for each category.
4. Find Emoji by tag or alias.
5. Support MacOS.


## EmojiImage

Library for creating UIImage from Emoji.

### Why would this be useful?

1. Designers like to use Emoji in the app interface, but the AppStore may reject the app if emojis are used as an image. [[1]](https://www.theverge.com/2018/2/8/16992830/apple-emoji-crackdown-cross-platform-apps-slack-whatsapp)

From App Store Review Guidelines:
> 4.5.6 Apps may use Unicode characters that render as Apple emoji in their app and app metadata. Apple emoji may not be used on other platforms or embedded directly in your app binary.

To get around this limitation, you can generate Emoji in runtime using this library.

2. You can use Emoji as text, but it's not always convenient. Sometimes you need to use emojis as an avatar placeholder or make emojis grayscale.

### How to use?

<table>
  
  <tr>
    <td align="center">
        <img src="https://user-images.githubusercontent.com/22199708/109399225-664d5780-7963-11eb-96a5-38e3e893c0b1.png" width="150px">
        <p>500x500 pt image</p>
    </td>
    <td>
      <pre lang="swift">
import EmojiImage
<br>
let emoji = Emoji.grinningFaceWithSmilingEyes
    .size(500)
    .image
      </pre>
    </td>
  </tr>
  
  <tr>
    <td align="center">
        <img src="https://user-images.githubusercontent.com/22199708/109400535-14a8cb00-796b-11eb-9c89-7756da1a62b9.png" width="150px">
        <p>500x500 pt image with 50 pt insets and teal elipse background</p>
    </td>
    <td>
      <pre lang="swift">
import EmojiImage
<br>
let emoji: UIImage = Emoji.guitar
    .size(500)
    .inset(by: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
    .background(UIColor.systemTeal)
    .ellipse()
    .image
      </pre>
    </td>
  </tr>
  
 <tr>
    <td align="center">
      <div>
        <img src="https://user-images.githubusercontent.com/22199708/109400612-7c5f1600-796b-11eb-809b-6caf9f340076.png" width="150px">
        <p>500x500 pt grayscale image</p>
        </div>
    </td>
    <td>
      <pre lang="swift">
import EmojiImage
<br>
let emoji = Emoji.fox    
    .size(500)
    .grayscale(1)
    .image
      </pre>
    </td>
  </tr>
  
  <tr>
    <td align="center">
      <div>
        <img src="https://user-images.githubusercontent.com/22199708/109400718-04ddb680-796c-11eb-9c78-2f8b0a2127d2.png" width="150px">
        <p>500x500 pt semi-grayscale image with 50 pt insets and yellow background</p>
        </div>
    </td>
    <td>
      <pre lang="swift">
import EmojiImage
<br>
let emoji = Emoji.owl
    .size(500)
    .inset(by: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
    .grayscale(0.5)
    .background(UIColor.systemYellow)
    .image
      </pre>
    </td>
  </tr>
  
  <tr>
    <td align="center">
      <div>
        <img src="https://user-images.githubusercontent.com/22199708/109401821-c26ba800-7972-11eb-88ca-56841c6f2ada.png" width="150px">
        <p>500x500 pt image with custom processing</p>
        </div>
    </td>
    <td>
      <pre lang="swift">
import CoreImage.CIFilterBuiltins
import EmojiImage
<br>
func blur(radius: Double) -> (UIImage) -> UIImage {
    return { image in
        guard let currentCGImage = image.cgImage else { return image }
        let currentCIImage = CIImage(cgImage: currentCGImage)
        let filter = CIFilter.gaussianBlur()
        filter.inputImage = currentCIImage
        filter.radius = radius
        guard let outputImage = filter.outputImage else { return image }
        let context = CIContext()
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            return processedImage
        } else {
            return image
        }
    }
}
<br>
let emoji = Emoji.eye
     .size(500)
     .process(with: blur(radius: 30))
     .image
      </pre>
    </td>
  </tr>
  
</table>


### TODO:

1. Create more built-in image processings
2. Find a way to get a high-quality images

## Other awesome repos
1. https://github.com/onmyway133/Smile
2. https://github.com/isaced/ISEmojiView

## Contribution
I will be very grateful for any help and good ideas for new features.  
Open issues, create pull requests, or write to me on Twitter ([@inlinable](https://twitter.com/inlinable)).
