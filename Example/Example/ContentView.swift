//
//  ContentView.swift
//  Example
//
//  Created by Aleksei Salangin on 5/11/20.
//  Copyright © 2020 Alexey Salangin. All rights reserved.
//

import SwiftUI
import Emoji

struct ContentView: View {
    let emoji: UIImage = Emoji.🦊
        .size(CGSize(width: 400, height: 400))
        .inset(by: UIEdgeInsets(top: 42, left: 42, bottom: 42, right: 42))
        .background(UIColor.systemFill)
        .ellipse()
        .image

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 24) {
                Text("Emoji").font(.largeTitle)
                Image(uiImage: emoji).resizable().frame(width: 200, height: 200)
                Image(uiImage: emoji).resizable().frame(width: 200, height: 200)
                Image(uiImage: emoji).resizable().frame(width: 200, height: 200)
                Image(uiImage: emoji).resizable().frame(width: 200, height: 200)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
