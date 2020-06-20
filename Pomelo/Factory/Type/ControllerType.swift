//
//  ControllerType.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import UIKit

/**
 Controller Type
 
 Object that defines the communication between View and ViewModel
 */
protocol ControllerType: class {
    associatedtype ViewModel: ViewModelType
    func configure(with viewModel: ViewModel)
}

