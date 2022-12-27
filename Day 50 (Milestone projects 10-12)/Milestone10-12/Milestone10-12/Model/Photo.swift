//
//  Photo.swift
//  Milestone10-12
//
//  Created by Edgaras Blauzdys on 2022-12-27.
//

import UIKit

class Photo: Codable {
    var title: String
    var image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
}


