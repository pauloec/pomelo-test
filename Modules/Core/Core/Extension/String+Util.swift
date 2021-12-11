//
//  String+Util.swift
//  Network
//
//  Created by Paulo Correa on 12/12/2564 BE.
//

import Foundation

extension String {
    public func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
