//
//  String+camelized.swift
//  EmojiCodegen
//
//  Created by Alexey Salangin on 6/18/20.
//  Copyright © 2020 Alexey Salangin. All rights reserved.
//

import Foundation

extension String {
    var uppercasingFirst: String {
        prefix(1).uppercased() + dropFirst()
    }

    var lowercasingFirst: String {
        prefix(1).lowercased() + dropFirst()
    }

    var camelized: String {
        guard !isEmpty else { return "" }

        let parts = self.components(separatedBy: CharacterSet.alphanumerics.inverted)

        let first = String(describing: parts.first!).lowercasingFirst
        let rest = parts.dropFirst().map({String($0).uppercasingFirst})

        return ([first] + rest).joined(separator: "")
    }
}
