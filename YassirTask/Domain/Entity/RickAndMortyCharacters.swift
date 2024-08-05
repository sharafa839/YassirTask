//
//  RickAndMortyCharactersList.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import Foundation

struct RickAndMortyCharacters {
    let nextPage: Int
    let charactersProperties: [CharactersProperties]
}

extension RickAndMortyCharacters {
    init(model: CharactersResponse) {
        let charactersProperties = model.results?.compactMap({CharactersProperties(model: $0)}) ?? []
        self.init(
            nextPage: Int(model.info?.next ?? "0") ?? 0,
            charactersProperties: charactersProperties
        )
    }
}

struct CharactersProperties {
    
    let id: Int
    let name: String
    let species: String
    let status: Status
    let image: String
    let gender: Gender
}

extension CharactersProperties {
    init?(model: CharactersPropertiesResponse) {
        guard let id = model.id else { return nil }
        self.init(
            id: id,
            name: model.name ?? "", 
            species: model.species ?? "",
            status: model.status ?? .unknown,
            image: model.image ?? "",
            gender: model.gender ?? .unknown
        )
    }
    
    static var sample: CharactersProperties {
        .init(
            id: 1,
            name: "Aqua Morty",
            species: "Humanoid",
            status: .alive,
            image: "https://rickandmortyapi.com/api/character/avatar/21.jpeg",
            gender: .female
        )
    }
}
