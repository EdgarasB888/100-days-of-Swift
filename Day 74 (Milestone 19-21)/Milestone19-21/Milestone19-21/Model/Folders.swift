//
//  Folders.swift
//  Milestone19-21
//
//  Created by Edgaras Blauzdys on 2023-01-31.
//

import Foundation

class Folders: Codable {
    var folders: [Folder]
    init(folders: [Folder]) {
        self.folders = folders
    }
}
