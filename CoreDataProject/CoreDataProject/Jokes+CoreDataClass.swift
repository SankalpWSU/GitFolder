//
//  Jokes+CoreDataClass.swift
//  CoreDataProject
//
//  Created by MCS on 9/27/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Jokes)
public class Jokes: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case joke
        case setup
        case delivery
        case id
    }
    public convenience required init(from decoder: Decoder) throws {
        guard let description = NSEntityDescription.entity(forEntityName: "Jokes", in: CoreDataManager.shared.context) else {throw CoreDataError.invalidEntityDescription}
        self.init(entity: description, insertInto: nil)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(String.self, forKey: .type)
        joke = try container.decodeIfPresent(String.self, forKey: .joke)
        setup = try container.decodeIfPresent(String.self, forKey: .setup)
        delivery = try container.decodeIfPresent(String.self, forKey: .delivery)
        id = try (container.decodeIfPresent(Int64.self, forKey: .id) ?? 0)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(category, forKey: .category)
        try container.encode(type, forKey: .type)
        try container.encode(joke, forKey: .joke)
        try container.encode(setup, forKey: .setup)
        try container.encode(delivery, forKey: .delivery)
        try container.encode(id, forKey: .id)
    }
}

enum CoreDataError: Error {
    case invalidEntityDescription
}
