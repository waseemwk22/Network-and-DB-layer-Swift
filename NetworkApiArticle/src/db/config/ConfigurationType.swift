//
// Mappable.swift
// Created by Waseem on 10/6/19
//

import Foundation

/* Storage config options */
public enum ConfigurationType {
    case basic(identifier: String)
    case inMemory(identifier: String?)

    func identifier() -> String? {
        switch self {
        case .basic(let identifier): return identifier
        case .inMemory(let identifier): return identifier
        }
    }
}
