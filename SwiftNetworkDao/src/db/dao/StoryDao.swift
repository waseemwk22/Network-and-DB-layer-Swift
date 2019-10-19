//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import UIKit

class StoryDao: BaseDao<Story, StoryEntity> {

    func findById(storyNumber: String) -> Story? {
        return super.fetch(predicate: NSPredicate(format: "storyNumber = %"+storyNumber)).last
    }
}
