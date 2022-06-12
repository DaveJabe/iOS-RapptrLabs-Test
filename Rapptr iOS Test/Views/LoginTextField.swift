//
//  LoginTextField.swift
//  Rapptr iOS Test
//
//  Created by David Jabech on 6/9/22.
//

import UIKit

// This custom UITextField class stylistically matches the textfields  in the mock-up
class LoginTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = .none
        backgroundColor = .white.withAlphaComponent(0.4)
        
        font = UIFont.systemFont(ofSize: 16)
        textColor = HexColor("1B1E1F")
        
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    let padding = UIEdgeInsets(
        top: 0,
        left: 16,
        bottom: 0,
        right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
