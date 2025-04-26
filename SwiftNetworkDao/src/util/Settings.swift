//
//  Settings.swift
//  Swift-Network-Dao
//
//  Created by Waseem Khan on 26/04/2025.
//  Copyright © 2025 Scykum. All rights reserved.
//

import Foundation

class Settings {
    let properties: Properties
    
    static let shared: Settings = .init()
    
    private init() {
        let bundle = Bundle(for: type(of: self))
        
        guard let fileURL = bundle.url(forResource: "Preferences", withExtension: ".plist"),
              let data = try? Data(contentsOf: fileURL),
              let properties = try? PropertyListDecoder().decode(Properties.self, from: data)
        else {
            fatalError("Failed to load Settings from Preferences.plist")
        }
        
        self.properties = properties
    }
}

struct Properties: Decodable {
    let debugServerUrl: String
    let liveServerUrl: String
    
    enum CodingKeys: String, CodingKey {
        case debugServerUrl
        case liveServerUrl
    }
}
