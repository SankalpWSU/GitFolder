//
//  DetailInfo.swift
//  AnimationProject
//
//  Created by MCS on 10/2/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

struct DetailInfo: Codable {
    let textEntry : [TextEntries]
    
    enum CodingKeys: String, CodingKey {
        case textEntry = "flavor_text_entries"
    }
}

struct TextEntries: Codable {
    let text: String
    let language: Language
    
    enum CodingKeys: String, CodingKey{
        case text = "flavor_text"
        case language
    }
}

struct Language: Codable {
    let name: String
}
