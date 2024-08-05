//
//  AppDelegate.swift
//  YassirTask
//
//  Created by Sharaf on 8/2/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Properties
    var window: UIWindow?
    private(set) lazy var coordinator = AppCoordinator()
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            let rickAndMortyCharactersListViewController = RickAndMortyCharactersListViewController(viewModel: RickAndMortyCharactersListViewModel())
            let uiNavigationController = UINavigationController(rootViewController: rickAndMortyCharactersListViewController)
            coordinator.setRoot(rickAndMortyCharactersListViewController)
            return true
        }
}

