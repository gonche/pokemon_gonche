//
//  Model.swift
//  pokemon
//
//  Created by Andrew Gardner on 03/08/2022.
//

import Foundation
import Combine

struct Pokemon: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results : [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable {
    let id = UUID()
    var name : String
    var url: String
}

class PokemonApi {
    @Published var count = 0

    func getResults(completion : @escaping ([PokemonEntry]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=\(count)&limit=20") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data!)

            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }
        .resume()
    }
}
