//
//  ContentView.swift
//  Example
//
//  Created by Aleksei Salangin on 5/11/20.
//  Copyright © 2020 Alexey Salangin. All rights reserved.
//

import SwiftUI
import Emoji
import EmojiImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    private let emoji0: UIImage = Emoji.grinningFaceWithSmilingEyes
        .size(500)
        .image

    private let emoji1: UIImage = Emoji.guitar
        .size(500)
        .inset(by: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        .background(UIColor.systemTeal)
        .ellipse()
        .image

    private let emoji2: UIImage = Emoji.fox
        .size(500)
        .grayscale(1)
        .image

    private let emoji3: UIImage = Emoji.owl
        .size(500)
        .inset(by: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        .grayscale(0.5)
        .background(UIColor.systemYellow)
        .image

    private let emoji4: UIImage = Emoji.eye
        .size(500)
        .process(with: Self.blur(radius: 30))
        .image

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 24) {
                Text("Emoji").font(.largeTitle)
                ForEach(
                    [emoji0, emoji1, emoji2, emoji3, emoji4],
                    id: \.self
                ) {
                    Image(uiImage: $0).resizable().frame(width: 200, height: 200)
                }
            }
        }
    }

    private static func blur(radius: Float) -> (UIImage) -> UIImage {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
