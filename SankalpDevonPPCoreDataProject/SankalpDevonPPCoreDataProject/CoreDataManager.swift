//
//  CoreDataManager.swift
//  SankalpDevonPPCoreDataProject
//
//  Created by MCS on 9/23/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "MyContainer")
        container.loadPersistentStores(completionHandler: { (description, error) in
            
            print(description)
            print(error)
        })
        return container
    
}()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func createNewList(with item: String) -> List {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "List", in: context) else {return nil}
        let newList = List(entity: entityDescription, insertInto: context)
        newList.item = item
        return newList
    }
}
