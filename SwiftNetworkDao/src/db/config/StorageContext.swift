//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import Foundation

protocol StorageContext {

    func create<DBEntity: Storable>(_ model: DBEntity.Type) -> DBEntity?

    func save(object: Storable) throws

    func saveAll(objects: [Storable]) throws

    func update(object: Storable) throws

    func delete(object: Storable) throws

    func deleteAll(_ model: Storable.Type) throws

    func fetch(_ model: Storable.Type, predicate: NSPredicate?, sorted: Sorted?) -> [Storable]
}
