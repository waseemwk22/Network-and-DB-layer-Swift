//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import UIKit

class DBManager {
    // MARK: - Private properties
    private var storageContext: StorageContext?

    // MARK: - Public properties
    static var shared = DBManager()

    lazy var storyDao = StoryDao(storageContext: storageContextImpl())

    private init() {}

    static func setup(storageContext: StorageContext) {
        shared.storageContext = storageContext
    }

    private func storageContextImpl() -> StorageContext {
        if self.storageContext != nil {
            return self.storageContext!
        }
        fatalError("You must call setup to configure the StoreContext before accessing any dao")
    }
}
