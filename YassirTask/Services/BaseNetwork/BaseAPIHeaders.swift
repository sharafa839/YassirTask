//
//  BaseAPIHeaders.swift
//  YassirTask
//
//  Created by Sharaf on 8/2/2024.
//

import Foundation

protocol BaseAPIHeadersProtocol {
    
    var headers: [String: String]? { get }
}

extension BaseAPIHeadersProtocol {
    
    var baseURL: URL {
       URL(string: "https://rickandmortyapi.com/api")!
    }
    
    var headers: [String : String]? {
        ["Content-Type": "Application/json"]
    }
}
