//
//  CoordinatorType.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import UIKit

/**
 Coordinator Type
 
 Object that defines the flow of views
 */
protocol CoordinatorType: class {
    // MARK: - Calls the rootViewController (or any ViewController) which is defined on site
    
    /// Start of flow
    func start()
    
    /// Initial controller
    var rootViewController: UIViewController { get }
}
