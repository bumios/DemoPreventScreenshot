//
//  UIView+PinEdges.swift
//  DemoPreventScreenshot
//
//  Created by lakshmi-12493 on 29/08/23.
//

import UIKit

extension UIView {
    func pin(_ type: NSLayoutConstraint.Attribute) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: type,
                                            relatedBy: .equal,
                                            toItem: superview, attribute: type,
                                            multiplier: 1, constant: 0)

        constraint.priority = UILayoutPriority.init(999)
        constraint.isActive = true
    }

    func pinEdges() {
        pin(.top)
        pin(.bottom)
        pin(.leading)
        pin(.trailing)
    }
}
