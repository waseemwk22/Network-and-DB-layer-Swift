//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import Foundation
import CoreData


extension StoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryEntity> {
        return NSFetchRequest<StoryEntity>(entityName: "StoryEntity")
    }

    @NSManaged public var storyNumber: String?
    @NSManaged public var title: String?
    @NSManaged public var clapsCount: Int32
    @NSManaged public var published: Bool

}
