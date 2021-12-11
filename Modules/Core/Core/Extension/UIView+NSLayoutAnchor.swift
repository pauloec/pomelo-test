//
//  UIView+NSLayoutAnchor.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

import UIKit

extension UIView {
    public func anchor(top: NSLayoutYAxisAnchor?,
                       leading: NSLayoutXAxisAnchor?,
                       bottom: NSLayoutYAxisAnchor?,
                       trailing: NSLayoutXAxisAnchor?,
                       centerY: NSLayoutYAxisAnchor? = nil,
                       centerX: NSLayoutXAxisAnchor? = nil,
                       padding: UIEdgeInsets = .zero,
                       size: CGSize = .zero,
                       topPriority: UILayoutPriority = .defaultLow,
                       bottomPriority: UILayoutPriority = .defaultLow,
                       leadingPriority: UILayoutPriority = .defaultLow,
                       trailingPriority: UILayoutPriority = .defaultLow,
                       centerYPriority: UILayoutPriority = .defaultLow,
                       centerXPriority: UILayoutPriority = .defaultLow,
                       widthPriority: UILayoutPriority = .defaultLow,
                       heightPriority: UILayoutPriority = .defaultLow) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            let topAnchor = topAnchor.constraint(equalTo: top, constant: padding.top)
            topAnchor.isActive = true
            topAnchor.priority = topPriority
        }

        if let leading = leading {
            let leadingAnchor = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
            leadingAnchor.isActive = true
            leadingAnchor.priority = leadingPriority
        }

        if let bottom = bottom {
            let bottomAnchor = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
            bottomAnchor.isActive = true
            bottomAnchor.priority = bottomPriority
        }

        if let trailing = trailing {
            let trailingAnchor = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
            trailingAnchor.isActive = true
            trailingAnchor.priority = trailingPriority
        }

        if let centerY = centerY {
            let centerYAnchor = centerYAnchor.constraint(equalTo: centerY)
            centerYAnchor.isActive = true
            centerYAnchor.priority = centerYPriority
        }

        if let centerX = centerX {
            let centerXAnchor = centerXAnchor.constraint(equalTo: centerX)
            centerXAnchor.isActive = true
            centerXAnchor.priority = centerXPriority
        }

        if size.width != 0 {
            let widthAnchor = widthAnchor.constraint(equalToConstant: size.width)
            widthAnchor.isActive = true
            widthAnchor.priority = widthPriority
        }

        if size.height != 0 {
            let heightAnchor = heightAnchor.constraint(equalToConstant: size.height)
            heightAnchor.isActive = true
            heightAnchor.priority = heightPriority
        }
    }

    public func anchorSuperview() {
        anchor(top: superview?.safeAreaLayoutGuide.topAnchor,
               leading: superview?.safeAreaLayoutGuide.leadingAnchor,
               bottom: superview?.safeAreaLayoutGuide.bottomAnchor,
               trailing: superview?.safeAreaLayoutGuide.trailingAnchor)
    }
}
