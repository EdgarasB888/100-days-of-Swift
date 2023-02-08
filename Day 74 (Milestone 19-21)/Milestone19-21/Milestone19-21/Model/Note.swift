//
//  Note.swift
//  Milestone19-21
//
//  Created by Edgaras Blauzdys on 2023-01-31.
//

import Foundation

class Note: Codable {
    var name: String?
    var text: String?
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
    
    init() {
        
    }
}
