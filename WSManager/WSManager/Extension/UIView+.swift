//
//  UIImageView.swift
//  WeSports
//
//  Created by datNguyem on 16/11/2021.
//

import Foundation
import UIKit

extension UIView {
    func makeCircle() {
        clipsToBounds = true
        layer.cornerRadius = bounds.height / 2
    }
    
    func makeRadius(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    func makeRadius(radius: CGFloat, mask: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = mask
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
            self.layer.addSublayer(border)
        }

        func addRightBorderWithColor(color: UIColor, width: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
            self.layer.addSublayer(border)
        }

        func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
            self.layer.addSublayer(border)
        }

        func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
            self.layer.addSublayer(border)
        }
}
