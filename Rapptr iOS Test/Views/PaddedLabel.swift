//
//  PaddedLabel.swift
//  Rapptr iOS Test
//
//  Created by David Jabech on 6/11/22.
//

import UIKit

// This custom UILabel class accommodates the 8 point padding around the text in the message bubble as indicated in the mock-up
class PaddedLabel: UILabel {
    
    var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: contentInsets))
        }

        override var intrinsicContentSize: CGSize {
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + contentInsets.left + contentInsets.right,
                          height: size.height + contentInsets.top + contentInsets.bottom)
        }

        override var bounds: CGRect {
            didSet {
                preferredMaxLayoutWidth = bounds.width - (contentInsets.left + contentInsets.right)
            }
        }
}
