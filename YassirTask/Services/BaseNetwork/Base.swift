//
//  Base.swift
//
//  Created by Sharaf on 8/2/2024.
//

import Foundation

typealias Parameters = [String: Any]

//MARK: - Switch live to testing and the otherwise
enum NetworkServiceType {
    
    case live
    case test
}

public struct NetworkError: Error, LocalizedError, Codable {
    
    var code: Int = 0
    var message: String = ""
    
    public var localizedDescription: String {
        message
    }
    
    public var errorDescription: String? {
        message
    }
}
