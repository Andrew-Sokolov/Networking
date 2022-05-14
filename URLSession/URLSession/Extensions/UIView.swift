//
//  UIView.swift
//  URLSession
//

import UIKit

extension UIView {
    
    func setCornerRadius(_ value: CGFloat) {
        layer.cornerRadius = value
        clipsToBounds = value > 0
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
}
