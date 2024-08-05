//
//  RickAndMortyCharactersList.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import Foundation
import Combine

class RickAndMortyCharactersListViewModel {
    
    let onLoading: CurrentValueSubject<Bool, Never> = .init(false)
    let onError: PassthroughSubject<String, Never> = .init()
    let useCase: GetRickAndMortyCharactersListUseCaseProtocol
    let RickAndMortyCharacters: PassthroughSubject<RickAndMortyCharacters, Never> = .init()
    let characterProperties: CurrentValueSubject<[CharactersProperties], Never> = .init([])
    let currentPage: CurrentValueSubject<Int, Never> = .init(1)
    var allCharactersProperties: [CharactersProperties] = []
    init(useCase: GetRickAndMortyCharactersListUseCaseProtocol = GetRickAndMortyCharactersListUseCase()) {
        self.useCase = useCase
        getRickAndMortyCharacters(currentPage: currentPage.value)
    }
    
    func getRickAndMortyCharacters(currentPage: Int) {
        onLoading.send(true)
        useCase.getCharacters(page: currentPage) { [weak self] value in
            guard let self else { return }
            onLoading.send(false)
            switch value {
            case .success(let rickAndMortyCharacters):
                allCharactersProperties.append(contentsOf: rickAndMortyCharacters.charactersProperties)
                RickAndMortyCharacters.send(rickAndMortyCharacters)
                characterProperties.send(allCharactersProperties)
            case .failure(let error):
                onError.send(error.localizedDescription)
            }
        }
    }
    
    func getRickAndMortyCharactersBy(_ status: Status) {
        characterProperties.send(allCharactersProperties.filter({$0.status == status}))
    }
}
