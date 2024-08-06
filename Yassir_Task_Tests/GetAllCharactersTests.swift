//
//  YassirTaskTests.swift
//  YassirTaskTests
//
//  Created by Sharaf on 8/5/24.
//

import XCTest
@testable import YassirTask

final class GetAllCharacters: XCTestCase {

    var characterUseCase: GetCharactersListUseCaseProtocol!
    var repo: CharactersRepoProtocol!
    var sut: CharactersListViewModel!
    var rickAndMortyCharacters: CharactersResponse?

    override func setUpWithError() throws {
        repo = CharactersRepo(type: .test)
        characterUseCase = GetCharactersListUseCase(repo: repo)
        sut = CharactersListViewModel(useCase: characterUseCase)
        rickAndMortyCharacters = nil
    }

    override func tearDownWithError() throws {
        repo = nil
        characterUseCase = nil
        sut = nil
    }

    func testCallingApiMock() throws {
        let expect = expectation(description: "getAllCharacters")
        repo.getCharacters(page: 1, status: nil) { [weak self] result in
            guard let self else { return }
            expect.fulfill()
            switch result {
            case .success(let response):
                rickAndMortyCharacters = response
            case .failure(let error):
                XCTAssert(false, error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert((rickAndMortyCharacters?.info?.pages == 42), "")
        XCTAssertEqual(rickAndMortyCharacters?.results?.first?.name , "Rick Sanchez")
        XCTAssertEqual(rickAndMortyCharacters?.results?.first?.gender, .male)
    }
}
