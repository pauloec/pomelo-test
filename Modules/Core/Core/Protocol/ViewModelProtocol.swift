//
//  ViewModelType.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

public protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
}
