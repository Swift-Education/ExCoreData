//
//  PersonDTO.swift
//  ExCoreData
//
//  Created by 강동영 on 12/18/24.
//

import Foundation
import CoreData

struct PersonDTO: EntityTransformAble {
    let name: String
    
    func toEntity(context: NSManagedObjectContext) -> Person {
        let description = NSEntityDescription.entity(forEntityName: "Person", in: context)!
        return Person(entity: description, insertInto: context)
    }
}
