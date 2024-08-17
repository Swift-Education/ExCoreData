//
//  PersistentManager.swift
//  ExCoreData
//
//  Created by 강동영 on 3/4/24.
//

import CoreData
import Foundation

final class PersistentManager: ObservableObject {
    static let shared: PersistentManager = PersistentManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: PersistentString.container)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        }
    }
    
    func fetchPerson() -> [Person] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: PersistentString.person)
        
        let fetchResult = try! context.fetch(fetchRequest)
        
        fetchResult.forEach {
            $0.value(forKey: PersonEntityType.name) as? String
        }
        return []
    }
}

fileprivate enum PersistentString {
    static let container: String = "Person"
    static let person: String = "Person"
}

fileprivate enum PersonEntityType {
    static let name: String = "name"
}
