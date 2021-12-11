//
//  CoordinatorType.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

import UIKit

public protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    func start()
}
