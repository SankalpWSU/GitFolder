//
//  Pokemon.swift
//  AnimationProject
//
//  Created by MCS on 10/1/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let index: Int
    let species: Species
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey{
        case name
        case index = "order"
        case species
        case sprites
    }
}
struct Species: Codable {
    let url: String
}

struct Sprites: Codable {
    let front_default: String
}
