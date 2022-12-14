//
//  PokemonImage.swift
//  pokemon
//
//  Created by Andrew Gardner on 05/08/2022.
//

import SwiftUI
import CachedAsyncImage

struct PokemonImage: View {
    var imageLink = ""
    @State private var pokemonSprite = ""

    var body: some View {
        /// added a package to support caching of images from https://github.com/lorenzofiamingo/swiftui-cached-async-image
        CachedAsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 75, height: 75)
            .onAppear {
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                if loadedData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                }else{
                    getSprite(url: loadedData!)
                }
            }
            .clipShape(Circle())
            .foregroundColor(Color.gray.opacity(0.60))
    }
    func getSprite(url: String){
        var tempSprite: String?

        PokemonSelectedApi().getResults(url: url) { sprite in
            tempSprite = sprite.front_default
            self.pokemonSprite = tempSprite ?? "placeholder"
        }
    }
}

// URLCache+imageCache.swift

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
