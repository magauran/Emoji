//
//  main.swift
//  EmojiCodegen
//
//  Created by Alexey Salangin on 6/18/20.
//  Copyright © 2020 Alexey Salangin. All rights reserved.
//

import Foundation
import Combine

let url = URL(string: "https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json")!

let semaphore = DispatchSemaphore(value: 0)

let publisher = URLSession.shared
    .dataTaskPublisher(for: url)
    .map(\.data)
    .decode(type: [Emoji].self, decoder: JSONDecoder())

let cancellable = publisher.sink(
    receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            break
        }

        semaphore.signal()
    },
    receiveValue: { emojiList in
        generate(with: emojiList)
    }
)

_ = DispatchSemaphore(value: 0).wait(timeout: .now() + 20)
