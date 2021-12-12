//
//  PickupSearchCoordinator.swift
//  PickupSearch
//
//  Created by Paulo Correa on 11/12/2021.
//

import Core

public class PickupSearchCoordinator: CoordinatorProtocol {
    public var navigationController: UINavigationController
    private var pickupViewModel: PickupSearchViewModel?
    
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewModel = PickupSearchViewModel()
        let viewController = PickupSearchViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        self.pickupViewModel = viewModel
    }
}
