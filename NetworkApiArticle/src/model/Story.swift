//
// Story.swift
// Created by waseem on 10/1/19
//

import UIKit

class Story: DomainBaseEntity, Codable {
    var storyNumber: Int?
    var clapsCount: Int?
    var title: String?
    var published: Bool?
}
