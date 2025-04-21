//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import Foundation
import CoreData

extension CoreDataStorageContext {
    func create<DBEntity: Storable>(_ model: DBEntity.Type) -> DBEntity? {
        let entityDescription =  NSEntityDescription.entity(forEntityName: String.init(describing: model.self),
                                                            in: managedContext!)
        let entity = NSManagedObject(entity: entityDescription!,
                                     insertInto: managedContext)
        return entity as? DBEntity
    }

    func save(object: Storable) throws { }

    func saveAll(objects: [Storable]) throws { }

    func update(object: Storable) throws { }

    func delete(object: Storable) throws { }

    func deleteAll(_ model: Storable.Type) throws { }

    func fetch(_ model: Storable.Type, predicate: NSPredicate?, sorted: Sorted?) -> [Storable] {
        return []
    }

    func objectWithObjectId<DBEntity: Storable>(objectId: NSManagedObjectID) -> DBEntity? {
        do {
            let result = try managedContext!.existingObject(with: objectId)
            return result as? DBEntity
        } catch {
            print("Failure")
        }

        return nil
    }
}
