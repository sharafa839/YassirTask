//
//  RickAndMortyCharacterDetailsViewController.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import UIKit

internal final class RickAndMortyCharacterDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var speciesLabel: UILabel!
    @IBOutlet weak private var locationValueLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var statusView: UIView!
    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak private var backButtonView: UIView!
    @IBOutlet weak private var characterImageView: UIImageView!
    
    //MARK: - Properties
    private let viewModel: RickAndMortyCharacterDetailsViewModel
    
    //MARK: - Init
    
    init(viewModel: RickAndMortyCharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit\(Self.self)")
    }
    
    //MARK: - LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationController(isHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(character: viewModel.character)
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        setupNavigationController(isHidden: false)
    }
    
    //MARK: - Methods
    
    private func setupView() {
        backButtonView.circular()
        characterImageView.cornerRadius(25)
        statusView.cornerRadius(15)
    }
    
    private func configureUI(character: CharactersProperties) {
        let url = URL(string: character.image)
        characterImageView.kf.setImage(with: url)
        statusLabel.text = character.status.rawValue
        nameLabel.text = character.name
        speciesLabel.text = character.species
        genderLabel.text = character.gender.rawValue
        locationValueLabel.text = character.location
    }
    
    private func setupNavigationController(isHidden: Bool) {
        navigationController?.isNavigationBarHidden = isHidden
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
