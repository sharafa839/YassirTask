//
//  RickAndMortyCharactersListViewController.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import UIKit
import SwiftUI
import Combine

internal final class RickAndMortyCharactersListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private let viewModel: RickAndMortyCharactersListViewModel
    private var cancellable = Set<AnyCancellable>()

    //MARK: - Init
    init(viewModel: RickAndMortyCharactersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupViewModelObservers()
    }
    
    //MARK: - Methods
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterItemView")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCollectionView() {
        collectionView.register(UICollectionView.self, forCellWithReuseIdentifier: "")
    }
    
    private func setupViewModelObservers() {
        viewModel.characterProperties.sink { [weak self] value in
            self?.tableView.reloadData()
        }
        .store(in: &cancellable)
    }
}

extension RickAndMortyCharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characterProperties.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = viewModel.characterProperties.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterItemView", for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration(content: {
            CharacterItemView(character: character)
        })
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characterProperties.value[indexPath.row]
        
    }
}
