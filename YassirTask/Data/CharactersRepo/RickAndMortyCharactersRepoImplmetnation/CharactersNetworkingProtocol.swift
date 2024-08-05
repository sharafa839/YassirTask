//
//  PostNetworkingProtocol.swift
//  YassirTask
//
//  Created by Sharaf on 8/2/2024.
//

import Foundation


extension CharacterRepoProtocol  {
    
    private var repo: CharactersRepo {
        return CharactersRepo()
    }
    
    func getCharacters(page: Int, completion : @escaping(Result<CharactersResponse, Error>)->Void) {
        repo.defaultRequest(target: .getRickAndMortyCharacters(page: page), completion: completion)
    }
}
