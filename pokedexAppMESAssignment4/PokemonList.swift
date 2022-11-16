//
//  PokemonList.swift
//  pokedexAppMESAssignment4
//
//  Created by Muhammad Fahmi on 16/11/22.
//

import Foundation

struct PokemonList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let pokemons: [Pokemon]?
    
    enum CodingKeys: String, CodingKey  {
        case count
        case next
        case previous
        case pokemons = "results"
    }
    
}

// MARK: - Pokemon
struct Pokemon: Codable {
    let name: String?
    let url: String?
    var imageURL: String?
}
