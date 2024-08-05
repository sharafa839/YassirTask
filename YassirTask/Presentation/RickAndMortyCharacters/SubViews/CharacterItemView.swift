//
//  CharacterItemView.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import SwiftUI

struct CharacterItemView: View {
    
    private let character: CharactersProperties
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url:  URL(string: character.image)!) { image in
                    image
                        .resizable()
                        .frame(width: 120, height: 120)
                } placeholder: {
                    Text("Loading ...")
                        .frame(width: 120, height: 120)
                }
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.nameColor)
                    Text(character.species)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.speciesColor)
                }
                Spacer()
            }
            .padding()
        }
        .background(content: {
            RoundedRectangle(cornerRadius: 25)
                .stroke(.gray, lineWidth: 2)
        })
    }
    
    init(character: CharactersProperties) {
        self.character = character
    }
}

#Preview {
    CharacterItemView(character: .sample)
}
