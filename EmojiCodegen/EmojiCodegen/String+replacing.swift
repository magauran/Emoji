//
//  String+replacing.swift
//  EmojiCodegen
//
//  Created by Alexey Salangin on 6/18/20.
//  Copyright © 2020 Alexey Salangin. All rights reserved.
//

import Foundation

extension String {
    func replacingForbiddenSubstrings() -> String {
        self
            .replacingOccurrences(of: "1st", with: "first")
            .replacingOccurrences(of: "2nd", with: "second")
            .replacingOccurrences(of: "3rd", with: "third")
            .replacingOccurrences(of: "*", with: "asterisk")
            .replacingOccurrences(of: "#", with: "numberSign")
    }
}
