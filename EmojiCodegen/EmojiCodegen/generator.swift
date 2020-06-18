//
//  generator.swift
//  EmojiCodegen
//
//  Created by Alexey Salangin on 6/18/20.
//  Copyright © 2020 Alexey Salangin. All rights reserved.
//

import Foundation
import Stencil
import PathKit

let folderURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
let folderPath = URL(fileURLWithPath: #file).deletingLastPathComponent().path
let filePath = folderURL
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appendingPathComponent("Sources")
    .appendingPathComponent("Emoji")
    .appendingPathComponent("Emoji+Constants.swift")
    .path
let templateName = "template.swift"


let environment = Environment(
    loader: FileSystemLoader(paths: [Path(folderPath)]),
    trimBehavior: .smart
)

func generate(with emojiList: [Emoji]) {
    print("Generate a list of emojis with template \(folderPath)/\(templateName)")
    let rendered = try! environment.renderTemplate(name: templateName, context: ["emojiList": emojiList])
    try! rendered.write(toFile: filePath, atomically: true, encoding: .utf8)
    print("File saved to \(filePath)")
}
