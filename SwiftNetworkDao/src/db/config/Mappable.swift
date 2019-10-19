//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import Foundation
import CoreData

protocol Mappable {
    var objectID: NSManagedObjectID? { get set }
    init()
}
