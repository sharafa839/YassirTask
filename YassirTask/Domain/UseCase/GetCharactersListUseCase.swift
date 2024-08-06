//
//  GetCharactersListUseCase.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import Foundation

protocol GetCharactersListUseCaseProtocol {
    func getCharacters(page: Int, status: Status?, completion: @escaping(Result<RickAndMortyCharacters, Error>)-> Void)
}

internal final class GetCharactersListUseCase: GetCharactersListUseCaseProtocol {
    let repo: CharactersRepoProtocol
    
    init(repo: CharactersRepoProtocol = CharactersRepo()) {
        self.repo = repo
    }
    
    func getCharacters(page: Int, status: Status? = nil, completion: @escaping(Result<RickAndMortyCharacters, Error>)-> Void) {
        repo.getCharacters(page: page, status: status) {value in
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
