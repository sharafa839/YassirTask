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
    let status: CurrentValueSubject<Status?, Never> = .init(nil)
    var allCharactersProperties: [CharactersProperties] = []
    init(useCase: GetRickAndMortyCharactersListUseCaseProtocol = GetRickAndMortyCharactersListUseCase()) {
        self.useCase = useCase
    }
    
    func getRickAndMortyCharacters(currentPage: Int, status: Status? = nil) {
        guard self.status.value == status else {
            resetData()
            return
        }
        onLoading.send(true)
        useCase.getCharacters(page: currentPage, status: status) { [weak self] value in
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
    
    private func resetData() {
        currentPage.send(1)
        allCharactersProperties = []
        characterProperties.send([])
    }
}
