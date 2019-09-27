//
//  Highlight+CoreDataProperties.swift
//  ClueGameProject
//
//  Created by MCS on 9/26/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData


extension Highlight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Highlight> {
        return NSFetchRequest<Highlight>(entityName: "Highlight")
    }

    @NSManaged public var star: Bool
    @NSManaged public var answer: String
    @NSManaged public var title: String
    @NSManaged public var createDate: String
    @NSManaged public var airdate: String
    @NSManaged public var clueValue: Int64
    @NSManaged public var question: String
    @NSManaged public var id: Int64
}
