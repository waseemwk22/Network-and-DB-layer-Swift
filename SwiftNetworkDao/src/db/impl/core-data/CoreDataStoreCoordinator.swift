//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import Foundation
import CoreData

public enum StoreType: String {
    case sqLiteStoreType
    case inMemoryStoreType
}

class CoreDataStoreCoordinator {

    static func persistentStoreCoordinator(modelName: String? = nil, storeType: StoreType = .sqLiteStoreType) -> NSPersistentStoreCoordinator? {
        do {
            return try NSPersistentStoreCoordinator.coordinator(modelName: modelName, storeType: storeType)
        } catch {
            print("CoreData: Unresolved error \(error)")
        }
        return nil
    }
}

extension NSPersistentStoreCoordinator {

    /// NSPersistentStoreCoordinator error types
    public enum CoordinatorError: Error {
        /// .momd file not found
        case modelFileNotFound
        /// NSManagedObjectModel creation fail
        case modelCreationError
        /// Gettings document directory fail
        case storePathNotFound
    }

    /// Return NSPersistentStoreCoordinator object
    static func coordinator(modelName: String? = nil, storeType: StoreType) throws -> NSPersistentStoreCoordinator? {

        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            throw CoordinatorError.modelFileNotFound
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoordinatorError.modelCreationError
        }

        let persistentContainer = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        if storeType == .inMemoryStoreType {
            try persistentContainer.configureInMemoryStore()
        } else {
            try persistentContainer.configureSQLiteStore(name: modelName!)
        }
        return persistentContainer
    }

}

extension NSPersistentStoreCoordinator {

    func configureSQLiteStore(name: String) throws {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            throw CoordinatorError.storePathNotFound
        }

        do {
            let url = documents.appendingPathComponent("\(name).sqlite")
            let options = [ NSMigratePersistentStoresAutomaticallyOption: true,
                            NSInferMappingModelAutomaticallyOption: true ]
            try self.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            throw error
        }
    }

    func configureInMemoryStore() throws {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env

        self.addPersistentStore(with: description) { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
    }

}
