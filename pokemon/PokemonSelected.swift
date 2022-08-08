//
//  Pokemon.swift
//  pokemon
//
//  Created by Andrew Gardner on 04/08/2022.
//

import Foundation

struct PokemonSelected: Codable {
    var sprites : PokemonSprites
    var weight: Int
}

struct PokemonSprites: Codable {
    var front_default : String
}

class PokemonSelectedApi {
    func getResults(url: String, completion : @escaping (PokemonSprites) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let pokemonSprite = try! JSONDecoder().decode(PokemonSelected.self, from: data!)
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)
            }
        }
        .resume()
    }
}
