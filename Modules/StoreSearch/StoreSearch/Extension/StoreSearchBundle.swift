//
//  StoreSearchBundle.swift
//  StoreSearch
//
//  Created by Paulo Correa on 11/12/2021.
//

import Foundation

public enum StoreSearchFramework {
    public static let useResourceBundles = true
    public static let bundleName = "StoreSearch.bundle"
}

private class GetBundle {}

extension Bundle {
    public class func StoreSearchResourceBundle() -> Bundle {
        let framework = Bundle(for: GetBundle.self)
        guard StoreSearchFramework.useResourceBundles else {
            return framework
        }
        guard let resourceBundleURL = framework.url(
            forResource: StoreSearchFramework.bundleName,
            withExtension: nil)
        else {
            fatalError("\(StoreSearchFramework.bundleName) not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access \(StoreSearchFramework.bundleName)")
        }
        return resourceBundle
    }
}

extension UIImage {
    class func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle.StoreSearchResourceBundle(), compatibleWith: nil) ?? UIImage()
    }
}
