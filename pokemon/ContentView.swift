//
//  ContentView.swift
//  pokemon
//
//  Created by Andrew Gardner on 03/08/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? pokemon : pokemon.filter ({
                    $0.name.contains(searchText.lowercased())
                })) { entry in
                    HStack {
                        PokemonImage(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        NavigationLink("\(entry.name)".capitalized, destination: PokemonStats(name: entry.name))
                    }
                }
            }
            .onAppear {
                PokemonApi().getResults() { pokemon in
                    self.pokemon = pokemon
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokemon Finder")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
