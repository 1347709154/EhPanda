//
//  Misc.swift
//  EhPanda
//
//  Created by 荒木辰造 on R 3/01/15.
//

import Foundation

typealias FavoritesIndex = Int
typealias Depth = Int
typealias Percentage = Int
typealias Keyword = String
typealias Identity = String
typealias APIKey = String
typealias CurrentGP = String
typealias CurrentCredits = String
typealias Resp = String

struct PageNumber {
    var current = 0
    var maximum = 0
}

struct AssociatedKeyword: Equatable {
    var category: String?
    var content: String?
    var title: String?
}

struct AssociatedItem {
    var keyword = AssociatedKeyword()
    var pageNum = PageNumber()
    var mangas: [Manga]
}

struct Greeting: Identifiable, Codable, Equatable {
    var id = UUID()

    var gainedEXP: Int?
    var gainedCredits: Int?
    var gainedGP: Int?
    var gainedHath: Int?
    var updateTime: Date?

    var strings: [String] {
        var strings = [String]()

        if let exp = gainedEXP?.withComma {
            strings.append(exp + " EXP")
        }
        if let credits = gainedCredits?.withComma {
            strings.append(credits + " Credits")
        }
        if let galleryPoint = gainedGP?.withComma {
            strings.append(galleryPoint + " GP")
        }
        if let hath = gainedHath?.withComma {
            strings.append(hath + " Hath")
        }

        return strings
    }

    var gainContent: String? {
        guard !strings.isEmpty else { return nil }

        var base = "GAINCONTENT_START".localized()

        if strings.count == 1 {
            base += strings[0]
        } else {
            let stringsToJoin = strings.count > 2
                ? strings.dropLast() : strings

            base += stringsToJoin
                .joined(
                    separator:
                        "GAINCONTENT_SEPARATOR"
                        .localized()
                )
            if strings.count > 2 {
                base += "GAINCONTENT_AND".localized()
                base += strings[strings.count - 1]
            }
        }

        base += "GAINCONTENT_END".localized()

        return base
    }

    var gainedNothing: Bool {
        [
            gainedEXP,
            gainedCredits,
            gainedGP,
            gainedHath
        ]
        .compactMap({ $0 })
        .isEmpty
    }
}
