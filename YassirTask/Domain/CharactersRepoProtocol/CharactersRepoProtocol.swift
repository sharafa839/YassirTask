//
//  CharactersRepoProtocol.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import Foundation

protocol CharacterRepoProtocol {
    
    func getCharacters(page: Int, completion : @escaping(Result<CharactersResponse, Error>)->Void)
}
