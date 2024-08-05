//
//  PostApi.swift
//  YassirTask
//
//  Created by Sharaf on 8/2/2024.
//

import Foundation
import Moya

enum CharactersApi {
    
    case getRickAndMortyCharacters(page: Int)
}

extension CharactersApi: TargetType, BaseAPIHeadersProtocol {
    
    var path: String {
        switch self {
        case .getRickAndMortyCharacters:
            return "/character/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRickAndMortyCharacters:
            return .get
            
        }
    }
    
    var task: Task {
        switch self {
        case .getRickAndMortyCharacters(let page):
            return .requestParameters(parameters: ["page": "\(page)"], encoding: URLEncoding.default)
            
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getRickAndMortyCharacters:
            return (try? JSONLoader.loadData(file: "")) ?? Data()
        }
    }
    
}