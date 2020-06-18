//
//  Emoji.swift
//  EmojiCodegen
//
//  Created by Alexey Salangin on 6/18/20.
//  Copyright © 2020 Alexey Salangin. All rights reserved.
//

enum Category: String, Decodable {
    case smileysAndEmotion = "Smileys & Emotion"
    case peopleAndBody = "People & Body"
    case animalsAndNature = "Animals & Nature"
    case foodAndDrink = "Food & Drink"
    case travelAndPlaces = "Travel & Places"
    case activities = "Activities"
    case objects = "Objects"
    case symbols = "Symbols"
    case flags = "Flags"
}

struct Emoji: Decodable {
    let emoji: String
    let name: String
    let description: String
    let category: Category
    let aliases: [String]
    let tags: [String]
    let unicodeVersion: String
    let iOSVersion: String

    enum CodingKeys: String, CodingKey {
        case emoji
        case description
        case category
        case aliases
        case tags
        case unicodeVersion = "unicode_version"
        case iOSVersion = "ios_version"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        emoji = try container.decode(String.self, forKey: .emoji)
        description = try container.decode(String.self, forKey: .description)
        category = try container.decode(Category.self, forKey: .category)
        aliases = try container.decode([String].self, forKey: .aliases)
        tags = try container.decode([String].self, forKey: .tags)
        unicodeVersion = try container.decode(String.self, forKey: .unicodeVersion)
        iOSVersion = try container.decode(String.self, forKey: .iOSVersion)
        name = description.lowercased().replacingForbiddenSubstrings().camelized.escapingReservedWords()
    }
}
