//
//  CoreDataManager.swift
//  ClueGameProject
//
//  Created by MCS on 9/24/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ClueContainer")
        container.loadPersistentStores(completionHandler: { (description, error) in
            print(description)
            print(error)
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getSavedStar() -> [Highlight] {
        let fetchRequest = NSFetchRequest<Highlight>(entityName: "Highlight")
        let fetchedHighlight = try? context.fetch(fetchRequest)
        return fetchedHighlight ?? []
    }
    
    func saveHighlight() {
        guard context.hasChanges else {return}
        try? context.save()
    }
    
}

