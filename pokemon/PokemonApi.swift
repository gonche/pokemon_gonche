//
//  Model.swift
//  pokemon
//
//  Created by Andrew Gardner on 03/08/2022.
//

import Foundation
import Combine

//https://github.com/V8tr/InfiniteListSwiftUI/blob/master/InfiniteListSwiftUI/GithubAPI.swift

//https://pokeapi.co/docs/v2#resource-listspagination-section

//https://documenter.getpostman.com/view/12403653/TVK8cLiK

enum PokemonApi {
    static let pageSize = 20
    
    static func searchPokemon(query: String, page: Int) -> AnyPublisher<[Result], Error> {
        let url = URL(string:
//                        "https://api.github.com/search/repositories?q=\(query)&sort=stars&per_page=\(Self.pageSize)&page=\(page)")!
                      "https://pokeapi.co/api/v2/pokemon/?limit=\(self.pageSize)+\(page)")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!) })
            .tryMap { try JSONDecoder().decode(PokemonSearchResult<Result>.self, from: $0.data).items }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct PokemonSearchResult<T: Codable>: Codable {
    let items: [T]
}

struct Result: Codable {
    var name : String
    var url: String
}

