//
//  Hits+CoreDataClass.swift
//  CollectionViewTest
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Hits)
public class Hits: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case hits
        case total
        case totalHits
    }
    
    public convenience required init(from decoder: Decoder) throws {
    guard let description = NSEntityDescription.entity(forEntityName: "Hits", in: CoreDataManager.shared.context) else {throw NewCoreDataError.invalidEntityDescription}
    self.init(entity: description, insertInto: nil)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
        let hitsArray = try container.decode([Pictures].self, forKey: .hits)
        hits = Set(hitsArray)
        totalHits = try container.decode(Int64.self, forKey: .totalHits)
        total = try container.decode(Int64.self, forKey: .total)
    }
    public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hits, forKey: .hits)
        try container.encode(total, forKey: .total)
        try container.encode(totalHits, forKey: .totalHits)
    }

}

enum NewCoreDataError: Error {
    case invalidEntityDescription
}
