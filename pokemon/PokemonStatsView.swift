//
//  PokemonStats.swift
//  pokemon
//
//  Created by Andrew Gardner on 06/08/2022.
//

import Foundation
import SwiftUI

struct PokemonStats : View {
    let name: String

    var body: some View {
        VStack {
            Text(name)
                .onAppear{
                    ///TODO fetch abilities etc from stats api
                }
        }
        .navigationTitle("")
    }
}
