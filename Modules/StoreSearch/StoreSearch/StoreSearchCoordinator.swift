//
//  StoreSearchCoordinator.swift
//  StoreSearch
//
//  Created by Paulo Correa on 11/12/2021.
//

import Core

public class StoreSearchCoordinator: CoordinatorProtocol {
    public var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        print("start")
    }
}
