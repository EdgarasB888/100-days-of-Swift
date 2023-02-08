//
//  Folder.swift
//  Milestone19-21
//
//  Created by Edgaras Blauzdys on 2023-01-31.
//

import Foundation

class Folder: Codable {
    var name: String
    var notes: [Note]
    init(name: String, notes: [Note]) {
        self.name = name
        self.notes = notes
    }
}
