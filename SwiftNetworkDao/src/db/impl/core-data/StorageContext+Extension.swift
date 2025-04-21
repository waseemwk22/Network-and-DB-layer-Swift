//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import Foundation
import CoreData

extension StorageContext {
    func objectWithObjectId<DBEntity: Storable>(objectId: NSManagedObjectID) -> DBEntity? {
        return nil
    }
}
