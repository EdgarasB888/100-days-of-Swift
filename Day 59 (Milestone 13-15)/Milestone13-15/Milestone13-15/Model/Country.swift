//
//  Country.swift
//  Milestone13-15
//
//  Created by Edgaras Blauzdys on 2023-01-04.
//

import Foundation

struct Countries: Codable {
    let countries: [Country]
}

// MARK: - Country
struct Country: Codable {
    let name, capital: String
    let population, area: Int
    let currency: String
}
