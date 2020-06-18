//
//  String+escaping.swift
//  EmojiCodegen
//
//  Created by Alexey Salangin on 6/18/20.
//  Copyright © 2020 Alexey Salangin. All rights reserved.
//

import Foundation

extension String {
    func escapingReservedWords() -> String {
        if self == "guard" {
            return self.replacingOccurrences(of: "guard", with: "`guard`")
        }
        return self
    }
}
