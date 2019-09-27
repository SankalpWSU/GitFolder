//
//  Highlight+CoreDataClass.swift
//  ClueGameProject
//
//  Created by MCS on 9/26/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Highlight)
public class Highlight: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case answer
        case question
        case clueValue = "value"
        case airdate
        case createDate = "created_at"
        case id 
        case category
    }
    
    enum categoryCodingKeys: String, CodingKey{
        case title
    }
    
    
    public convenience required init(from decoder: Decoder) throws {
        guard let description = NSEntityDescription.entity(forEntityName: "Highlight", in: CoreDataManager.shared.context) else {
        throw CoreDataError.invalidEntityDescription
        }
        self.init(entity: description, insertInto: nil)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let categoryContainer = try container.nestedContainer(keyedBy: categoryCodingKeys.self, forKey: .category)
        answer = try container.decode(String.self, forKey: .answer)
        question = try container.decode(String.self, forKey: .question)
        clueValue = try (container.decodeIfPresent(Int64.self, forKey: .clueValue) ?? 0)
        airdate = try container.decode(String.self, forKey: .airdate)
        createDate = try container.decode(String.self, forKey: .createDate)
        title = try categoryContainer.decode(String.self, forKey: .title)
        id = try container.decode(Int64.self, forKey: .id)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var categoryContainer = container.nestedContainer(keyedBy: categoryCodingKeys.self, forKey: .category)
        try container.encode(answer, forKey: .answer)
        try container.encode(question, forKey: .question)
        try container.encode(clueValue, forKey: .clueValue)
        try container.encode(airdate, forKey: .airdate)
        try container.encode(createDate, forKey: .createDate)
        try container.encode(id, forKey: .id)
        try categoryContainer.encode(title, forKey: .title)
    }
}

enum CoreDataError: Error {
    case invalidEntityDescription
}
