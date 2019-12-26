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

    @NSManaged public var totalHits: Int64
    @NSManaged public var total: Int64
    @NSManaged public var hits: Set<Pictures>

}
