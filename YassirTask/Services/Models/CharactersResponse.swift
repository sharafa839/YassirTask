//
//  CharactersResponse.swift
//  YassirTask
//
//  Created by Sharaf on 8/2/2024.
//

import Foundation

// MARK: - Post
internal struct CharactersResponse: Codable {
    let info: InfoResponse?
    let results: [CharactersPropertiesResponse]?
}

// MARK: - Info
struct InfoResponse: Codable {
    let count, pages: Int?
    let next, prev: String?
}

// MARK: - Result
struct CharactersPropertiesResponse: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species, type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Status: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
