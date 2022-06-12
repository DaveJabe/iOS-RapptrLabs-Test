//
//  Extensions.swift
//  Rapptr iOS Test
//
//  Created by David Jabech on 6/11/22.
//

import UIKit

// Added this extension to match the padding within the UIButtons in MenuViewController to the mock-up with a simple function call
extension UIButton {
    func setIconAndLabelPadding(leftEndToIcon: CGFloat, iconToLabel: CGFloat) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: leftEndToIcon,
            bottom: 0,
            right: 0)
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: iconToLabel,
            bottom: 0,
            right: 0)
    }
}

extension UIImageView {
    func asCircle() {
        layer.cornerRadius = self.frame.size.width / 2
        layer.masksToBounds = true
    }
}
