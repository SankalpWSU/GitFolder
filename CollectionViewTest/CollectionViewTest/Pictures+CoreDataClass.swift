//
//  Pictures+CoreDataClass.swift
//  CollectionViewTest
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Pictures)
public class Pictures: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case image = "previewURL"
        case likes
        case views
        case comments
        case largeImage = "largeImageURL"
    }
    
    public convenience required init(from decoder: Decoder) throws {
        guard let des = NSEntityDescription.entity(forEntityName: "Pictures", in: CoreDataManager.shared.context) else {throw CoreDataError.invalidEntityDescription}
        self.init(entity: des, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decode(String.self, forKey: .image)
        likes = try container.decode(Int64.self, forKey: .likes)
        views = try container.decode(Int64.self, forKey: .views)
        comments = try container.decode(Int64.self, forKey: .comments)
        largeImage = try container.decode(String.self, forKey: .largeImage)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try container.encode(image, forKey: .image)
        try container.encode(likes, forKey: .likes)
        try container.encode(views, forKey: .views)
        try container.encode(comments, forKey: .comments)
        try container.encode(largeImage, forKey: .largeImage)
    }
}

enum CoreDataError: Error {
    case invalidEntityDescription
}
