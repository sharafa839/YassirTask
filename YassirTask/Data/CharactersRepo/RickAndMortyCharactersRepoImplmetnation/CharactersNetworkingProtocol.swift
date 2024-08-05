//
//  PostNetworkingProtocol.swift
//  YassirTask
//
//  Created by Sharaf on 8/2/2024.
//

import Foundation


extension CharactersRepoProtocol  {
    
    private var repo: CharactersRepo {
        return CharactersRepo()
    }
    
    func getCharacters(page: Int, status: Status?, completion : @escaping(Result<CharactersResponse, Error>)->Void) {
        repo.defaultRequest(target: .getRickAndMortyCharacters(page: page, status: status), completion: completion)
    }
}
