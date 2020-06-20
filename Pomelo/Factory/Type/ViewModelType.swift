//
//  ViewModelType.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import Foundation

/**
 View Model Type
 
 Object that defines the state of views
 */
protocol ViewModelType: class {
    
    associatedtype Input
    associatedtype Output

    /// Input from views (UIButtons, UI changes etc)
    var input: Input { get }
    
    /// Output to change views
    var output: Output { get }
}
