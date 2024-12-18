//
//  CoreDataManageable+EntityTransformAble.swift
//  ExCoreData
//
//  Created by 강동영 on 12/18/24.
//

import CoreData

protocol CoreDataManageable {
    associatedtype Model: EntityTransformAble
    associatedtype Entity: NSManagedObject
    func create(with model: Model)
    func fetch() -> [Entity]
    func delete(_ entity: Entity)
    func saveContext() throws
}

protocol EntityTransformAble {
    associatedtype Entity: NSManagedObject
    func toEntity(context: NSManagedObjectContext) -> Entity
}
