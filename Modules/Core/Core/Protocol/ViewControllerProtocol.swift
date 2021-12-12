//
//  ViewControllerProtocol.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

public protocol ViewControllerProtocol {
    associatedtype ViewModelProtocol
    init(viewModel: ViewModelProtocol)
    func setupViews()
    func bindViewModel()
}
