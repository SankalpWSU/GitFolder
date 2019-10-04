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
    }
    
    public convenience required init(from decoder: Decoder) throws {
    guard let description = NSEntityDescription.entity(forEntityName: "Hits", in: CoreDataManager.shared.context) else {throw NewCoreDataError.invalidEntityDescription}
    self.init(entity: description, insertInto: nil)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    hits = try container.decode([Pictures].self, forKey: .hits)
    }
    public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(hits, forKey: .hits)
    }
}

enum NewCoreDataError: Error {
    case invalidEntityDescription
}
