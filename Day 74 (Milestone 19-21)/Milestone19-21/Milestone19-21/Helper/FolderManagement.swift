//
//  FolderManagement.swift
//  Milestone19-21
//
//  Created by Edgaras Blauzdys on 2023-01-31.
//

import Foundation

class FolderManagement {
    static func saveFolders(_ folders: [Folder]) {
        let defaults = UserDefaults.standard
        let data = folders.map { try? JSONEncoder().encode($0)}
        defaults.set(data, forKey: "savedFolders")
        print("save")
    }

    static func loadFolders() -> [Folder]{
        let defaults = UserDefaults.standard
        guard let encodeData = defaults.array(forKey: "savedFolders") as? [Data] else {
            return []
        }
        
        return encodeData.map { try! JSONDecoder().decode(Folder.self, from: $0) }
    }
}


