//
//  ApplicationCoordinator.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import UIKit

class ApplicationCoordinator: CoordinatorType {
    private let presenter: UIWindow
    private var venueListViewController: VenueListViewController
    
    var rootViewController: UIViewController {
        return venueListViewController
    }
    
    init(presenter: UIWindow) {
        self.presenter = presenter
        
        let viewModel = VenueListViewControllerViewModel()
        self.venueListViewController = VenueListViewController()
        venueListViewController.configure(with: viewModel)
    }
    
    func start() {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        presenter.rootViewController = navigationController
        presenter.makeKeyAndVisible()
    }
}
