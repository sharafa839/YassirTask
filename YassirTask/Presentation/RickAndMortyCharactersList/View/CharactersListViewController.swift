//
//  RickAndMortyCharactersListViewController.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import UIKit
import SwiftUI
import Combine

internal final class CharactersListViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private let viewModel: CharactersListViewModel
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - Init
    init(viewModel: CharactersListViewModel) {
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
        setupCollectionView()
        setupViewModelObservers()
        setupNavigationBar()
    }
    
    //MARK: - Methods
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterItemView")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "FilterItemView")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupViewModelObservers() {
        viewModel.characterProperties.sink { [weak self] value in
            self?.tableView.reloadData()
        }
        .store(in: &cancellable)
        viewModel.onLoading.sink {[weak self] value in
            guard let self else { return }
            value ? showActivityIndicator() : hideActivityIndicator()
        }
        .store(in: &cancellable)
        viewModel.currentPage.sink { [weak self] page in
            guard let self else { return }
            viewModel.getRickAndMortyCharacters(currentPage: page, status: viewModel.status.value)
        }
        .store(in: &cancellable)
        viewModel.status.sink { [weak self] value in
            guard let self else { return }
            guard let value else { return }
            viewModel.resetData()
            collectionView.reloadData()
        }
        .store(in: &cancellable)
    }
    
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleColor]
        title = "Characters"
    }
    
   private func scrollToEnd(indexPath: IndexPath) {
       if indexPath.row == viewModel.characterProperties.value.count - 1 && viewModel.currentPage.value < viewModel.totalPages {
            viewModel.currentPage.send(viewModel.currentPage.value + 1)
        }
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        scrollToEnd(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characterProperties.value[indexPath.row]
        let rickAndMortyCharacterDetailsViewModel = CharacterDetailsViewModel(character: character)
        let rickAndMortyCharacterDetailsViewController = CharacterDetailsViewController(viewModel: rickAndMortyCharacterDetailsViewModel)
        navigationController?.pushViewController(rickAndMortyCharacterDetailsViewController, animated: true)
    }
}

extension CharactersListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filtrationCases.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filter = viewModel.filtrationCases.value[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterItemView", for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration(content: {
            FilterItemView(filter: filter)
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filtar = viewModel.filtrationCases.value[indexPath.row]
        viewModel.selectFilter(filter: filtar)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -25
    }
}
