//
//  Hits+CoreDataProperties.swift
//  CollectionViewTest
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData


extension Hits {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hits> {
        return NSFetchRequest<Hits>(entityName: "Hits")
    }

    @NSManaged public var hits: [Pictures]
}

//struct Pictures: Codable {
//    let image: String
//    let likes: Int
//    let views: Int
//    let comments: Int
//    let largeImage: String
//
//    enum CodingKeys: String, CodingKey {
//            case image = "previewURL"
//            case likes
//            case views
//            case comments
//            case largeImage = "largeImageURL"
//        }
//}
