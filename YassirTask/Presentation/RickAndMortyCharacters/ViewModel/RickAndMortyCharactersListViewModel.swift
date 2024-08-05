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
    let characters: CurrentValueSubject<RickAndMortyCharacters?, Never> = .init(nil)
    let characterProperties: CurrentValueSubject<[CharactersProperties], Never> = .init([])
    let filtrationCases: CurrentValueSubject<[Filtration], Never> = .init(Filtration.allCases)
    let currentPage: CurrentValueSubject<Int, Never> = .init(1)
    let status: CurrentValueSubject<Filtration?, Never> = .init(nil)
    var totalPages: Int {
        characters.value?.totalPages ?? 0
    }
    private (set) var allCharactersProperties: [CharactersProperties] = []
    
    init(useCase: GetRickAndMortyCharactersListUseCaseProtocol = GetRickAndMortyCharactersListUseCase()) {
        self.useCase = useCase
    }
    
    deinit {
        print("deinit\(Self.self)")
    }
    
    func getRickAndMortyCharacters(currentPage: Int, status: Filtration? = nil) {
        onLoading.send(true)
        useCase.getCharacters(page: currentPage, status: status?.filter) { [weak self] value in
            guard let self else { return }
            onLoading.send(false)
            switch value {
            case .success(let characters):
                self.characters.send(characters)
                allCharactersProperties.append(contentsOf: characters.charactersProperties)
                characterProperties.send(allCharactersProperties)
            case .failure(let error):
                onError.send(error.localizedDescription)
            }
        }
    }
    
     func resetData() {
        currentPage.send(1)
        allCharactersProperties = []
        characterProperties.send([])
    }
    
    func selectFilter(filter: Filtration) {
        filtrationCases.send(Filtration.allCases)
        guard let index = filtrationCases.value.firstIndex(where: {$0 == filter}) else { return }
        filtrationCases.value[index].selected = true
        let filtrationCase = filtrationCases.value[index]
        status.send(filtrationCase)
    }
}
