//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import UIKit

class BaseDao<DomainEntity: Mappable, DBEntity: Storable> {
    private var storageContext: StorageContext?

    required init(storageContext: StorageContext) {
        self.storageContext = storageContext
    }

    func create() -> Mappable? {
        let dbEntity: DBEntity? = storageContext?.create(DBEntity.self)
        return mapToDomain(dbEntity: dbEntity!)
    }

    func save(object: DomainEntity) throws {
        var dbEntity: DBEntity?
        if object.objectID != nil {
            dbEntity = storageContext?.objectWithObjectId(objectId: object.objectID!)
        } else {
            dbEntity = storageContext?.create(DBEntity.self)
        }

        Mapper.mapToDB(from: object, target: dbEntity!)
        try storageContext?.save(object: dbEntity!)
    }

    func saveAll(objects: [DomainEntity]) throws {
        for domainEntity in objects {
            try self.save(object: domainEntity)
        }
    }

    func update(object: DomainEntity) throws {
        if object.objectID != nil {
            let dbEntity: DBEntity? = storageContext?.objectWithObjectId(objectId: object.objectID!)
            Mapper.mapToDB(from: object, target: dbEntity!)
            try storageContext?.update(object: dbEntity!)
        }
    }

    func delete(object: DomainEntity) throws {
        if object.objectID != nil {
            let dbEntity: DBEntity? = storageContext?.objectWithObjectId(objectId: object.objectID!)
            try storageContext?.delete(object: dbEntity!)
        }
    }

    func deleteAll() throws {
        try storageContext?.deleteAll(DBEntity.self)
    }

    func fetch(predicate: NSPredicate?, sorted: Sorted? = nil) -> [DomainEntity] {
        let dbEntities = storageContext?.fetch(DBEntity.self, predicate: predicate, sorted: sorted) as? [DBEntity]
        return mapToDomain(dbEntities: dbEntities)
    }

    private func mapToDomain(dbEntity: DBEntity) -> DomainEntity {
        var domainEntity = DomainEntity.init()
        Mapper.mapToDomain(from: dbEntity, target: &domainEntity)
        return domainEntity
    }

    private func mapToDomain(dbEntities: [DBEntity]?) -> [DomainEntity] {
        var domainEntities = [DomainEntity]()
        for dbEntity in dbEntities! {
            domainEntities.append(mapToDomain(dbEntity: dbEntity))
        }
        return domainEntities
    }
}
