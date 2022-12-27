//
//  Person.swift
//  Project10
//
//  Created by Edgaras Blauzdys on 2022-12-11.
//

import UIKit

//If we only write Swift code, it is much easier to use Codable protocol, which reads and writes JSON natively
class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
