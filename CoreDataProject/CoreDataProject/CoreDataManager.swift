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
    
    @discardableResult
    func createJoke(with joke: Jokes) ->Jokes? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Jokes", in: context) else {return nil}
        let newJoke = Jokes(entity: entityDescription, insertInto: context)
        newJoke.id = joke.id
        newJoke.category = joke.category
        newJoke.type = joke.type
        if newJoke.type == "single" {
            newJoke.joke = joke.joke
        }else {
            newJoke.setup = joke.setup
            newJoke.delivery = joke.delivery
        }
        print("New Joke created\(newJoke.category ?? "")")
        return newJoke
    }
    
    func getSavedJoke() -> [Jokes] {
        let fetchRequest = NSFetchRequest<Jokes>.init(entityName: "Jokes")
        let fetchedList = try? context.fetch(fetchRequest)
         return fetchedList ?? []
    }
    
    func saveFav() {
        guard context.hasChanges else {return}
        try? context.save()
    }
    
    func delListItem(at index: Int){
        let fetchRequest = NSFetchRequest<Jokes>.init(entityName: "Jokes")
        let fetchedList = try? context.fetch(fetchRequest)
        let objectToDel = fetchedList![index]
        context.delete(objectToDel)
        try? context.save()
    }
}
