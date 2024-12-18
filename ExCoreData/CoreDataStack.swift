//
//  CoreDataStack.swift
//  ExCoreData
//
//  Created by 강동영 on 3/4/24.
//

import CoreData
import Foundation

final class CoreDataStack: ObservableObject, CoreDataManageable {
    private let persistentContainer: NSPersistentContainer
    
    init(name: String) {
        persistentContainer = NSPersistentContainer(name: name)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func create(with model: PersonDTO) {
        let newPerson = model.toEntity(context: context)
        newPerson.name = model.name
        saveContext()
    }
    
    func fetch() -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    func delete(_ entity: Person) {
        context.delete(entity)
        saveContext()
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error.localizedDescription)")
            }
        }
    }
}

enum PersistentString {
    static let container: String = "Person"
    static let person: String = "Person"
}

fileprivate enum PersonEntityType {
    static let name: String = "name"
}
