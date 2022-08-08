//
//  PokemonStatsApi.swift
//  pokemon
//
//  Created by Andrew Gardner on 07/08/2022.
//

import Foundation

struct PokemonDetails: Codable {
    let abilities : PokemonAbility
}

struct PokemonAbility: Codable {
    var name : String
    var url: String
}

/// Note abilities is still a WIP

class PokemonStatsApi {
    func getResults(url: String, completion : @escaping (PokemonAbility) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let pokemonDetails = try! JSONDecoder().decode(PokemonDetails.self, from: data!)
            DispatchQueue.main.async {
                completion(pokemonDetails.abilities)
            }
        }
        .resume()
    }
}

