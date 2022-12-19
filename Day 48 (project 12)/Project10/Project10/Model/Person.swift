//
//  Person.swift
//  Project10
//
//  Created by Edgaras Blauzdys on 2022-12-11.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
