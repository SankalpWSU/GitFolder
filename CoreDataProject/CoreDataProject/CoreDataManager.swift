//
//  CoreDataManager.swift
//  CoreDataProject
//
//  Created by MCS on 9/27/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "myJokes")
        container.loadPersistentStores { (description, error) in
            print(description)
            print(error)
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveFav() {
        guard context.hasChanges else {return}
        try? context.save()
    }
}
