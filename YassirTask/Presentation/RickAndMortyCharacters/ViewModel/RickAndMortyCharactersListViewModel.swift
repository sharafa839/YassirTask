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
    init(useCase: GetRickAndMortyCharactersListUseCaseProtocol = GetRickAndMortyCharactersListUseCase()) {
        self.useCase = useCase
        getRickAndMortyCharacters()
    }
    
    func getRickAndMortyCharacters() {
        useCase.getCharacters(page: currentPage.value) { [weak self] value in
            guard let self else { return }
            switch value {
            case .success(let rickAndMortyCharacters):
                RickAndMortyCharacters.send(rickAndMortyCharacters)
                characterProperties.send(rickAndMortyCharacters.charactersProperties)
            case .failure(let error):
                onError.send(error.localizedDescription)
            }
        }
    }
}
