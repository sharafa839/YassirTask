//
//  GetRickAndMortyCharactersListUseCase.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import Foundation

protocol GetRickAndMortyCharactersListUseCaseProtocol {
    func getCharacters(page: Int, completion: @escaping(Result<RickAndMortyCharacters, Error>)-> Void)
}

class GetRickAndMortyCharactersListUseCase: GetRickAndMortyCharactersListUseCaseProtocol {
    let repo: CharacterRepoProtocol
    
    init(repo: CharacterRepoProtocol = CharactersRepo()) {
        self.repo = repo
    }
    
    func getCharacters(page: Int, completion: @escaping(Result<RickAndMortyCharacters, Error>)-> Void) {
        repo.getCharacters(page: page) {value in
            switch value {
            case .success(let response):
                let rickAndMortyCharactersList = RickAndMortyCharacters(model: response)
                completion(.success(rickAndMortyCharactersList))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}
