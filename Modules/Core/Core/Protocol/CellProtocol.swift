//
//  CellProtocol.swift
//  PickupSearch
//
//  Created by Paulo Correa on 12/12/2564 BE.
//

public protocol CellProtocol {
    associatedtype ViewModelProtocol
    static var identifier:  String { get }
    func setupViews()
    func bindViewModel(viewModel: ViewModelProtocol)
}
