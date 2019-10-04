//
//  CoreDataManager.swift
//  CollectionViewTest
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pictures")
        container.loadPersistentStores { (description, error) in
            print(description)
            print(error)
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
