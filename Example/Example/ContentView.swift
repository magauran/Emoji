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

struct ContentView: View {
    let emoji0: UIImage = Emoji.guitar
        .size(400)
        .inset(by: UIEdgeInsets(top: 42, left: 42, bottom: 42, right: 42))
        .background(UIColor.systemYellow)
        .ellipse()
        .image

    let emoji1: UIImage = Emoji.fox
        .size(400)
        .inset(by: UIEdgeInsets(top: 42, left: 42, bottom: 42, right: 42))
        .grayscale(1)
        .background(UIColor.systemBlue)
        .ellipse()
        .image

    let emoji2: UIImage = Emoji.owl
        .size(400)
        .inset(by: UIEdgeInsets(top: 42, left: 42, bottom: 42, right: 42))
        .grayscale(0.5)
        .background(UIColor.systemTeal)
        .image

    let emoji3: UIImage = Emoji.fullMoon
        .size(400)
        .inset(by: UIEdgeInsets(top: 42, left: 42, bottom: 42, right: 42))
        .background(.darkGray)
        .ellipse()
        .background(UIColor.black)
        .image

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 24) {
                Text("Emoji").font(.largeTitle)
                Image(uiImage: emoji0).resizable().frame(width: 200, height: 200)
                Image(uiImage: emoji1).resizable().frame(width: 200, height: 200)
                Image(uiImage: emoji2).resizable().frame(width: 200, height: 200)
                Image(uiImage: emoji3).resizable().frame(width: 200, height: 200)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
