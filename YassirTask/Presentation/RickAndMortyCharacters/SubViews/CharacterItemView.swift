//
//  CharacterItemView.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import SwiftUI
import Kingfisher

struct CharacterItemView: View {
    
    private let character: CharactersProperties
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: character.image)!)
                    .resizable()
                    .frame(width: 120, height: 120)
                
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
            if character.status == .alive {
                Color(
                    UIColor(
                        red: drand48(),
                        green: drand48(),
                        blue: drand48(),
                        alpha: 1
                    )
                )
                .cornerRadius(25)
            } else {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.gray, lineWidth: 2)
            }
        })
    }
    
    init(character: CharactersProperties) {
        self.character = character
    }
}

#Preview {
    CharacterItemView(character: .sample)
}
