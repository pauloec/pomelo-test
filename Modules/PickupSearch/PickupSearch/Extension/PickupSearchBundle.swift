//
//  StoreSearchBundle.swift
//  StoreSearch
//
//  Created by Paulo Correa on 11/12/2021.
//

import Foundation

public enum PickupSearchFramework {
    public static let useResourceBundles = true
    public static let bundleName = "PickupSearch.bundle"
}

private class GetBundle {}

extension Bundle {
    public class func PickupSearchResourceBundle() -> Bundle {
        let framework = Bundle(for: GetBundle.self)
        guard PickupSearchFramework.useResourceBundles else {
            return framework
        }
        guard let resourceBundleURL = framework.url(
            forResource: PickupSearchFramework.bundleName,
            withExtension: nil)
        else {
            fatalError("\(PickupSearchFramework.bundleName) not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access \(PickupSearchFramework.bundleName)")
        }
        return resourceBundle
    }
}

extension UIImage {
    class func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle.PickupSearchResourceBundle(), compatibleWith: nil) ?? UIImage()
    }
}
