//
//  ControllerProtocol.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

import Foundation

public protocol ControllerProtocol {
    associatedtype ViewModelProtocol
    init(viewModel: ViewModelProtocol)
    func setupViews()
}
