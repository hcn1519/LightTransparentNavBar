//
//  LightTransparentNavBar.swift
//  LightTransparentNavBar
//
//  Created by 홍창남 on 2018. 2. 17..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import UIKit

open class LightTransparentNavBar: UINavigationBar {
    open var color: UIColor = .white

    open override var alpha: CGFloat {
        didSet {
            if alpha > 1 {
                alpha = 1.0
                self.isTranslucent = false
                self.setBackground(color: color)
            } else if alpha < 0 {
                alpha = 0.0
                self.isTranslucent = true
                self.setBackground(color: color.withAlphaComponent(alpha))
            } else {
                self.isTranslucent = true
                self.setBackground(color: color.withAlphaComponent(alpha))
            }
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.showTransparentNavigationBar()
    }

    open var isTransparent: Bool = true {
        didSet {
            if isTransparent {
                self.showTransparentNavigationBar()
            } else {
                self.hideTransparentNavigationBar()
            }
        }
    }

    open var hideBottomNavigationLine: Bool {
        get {
            if let hairLine = self.hairlineImageView {
                return hairLine.isHidden
            }
            return false
        } set {
            self.hairlineImageView?.isHidden = newValue
        }
    }
}
extension LightTransparentNavBar {
    func setBackground(color: UIColor) {
        self.setBackgroundImage(setImageFrom(color: color), for: UIBarMetrics.default)
    }

    private func setImageFrom(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)

        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }

        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        }

        return UIImage()
    }

    func showTransparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for:.default)
        self.isTranslucent = true
    }

    func hideTransparentNavigationBar() {
        self.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:.default)
        self.isTranslucent = UINavigationBar.appearance().isTranslucent
    }
}

extension UIView {
    fileprivate var hairlineImageView: UIImageView? {
        return hairlineImageView(in: self)
    }

    fileprivate func hairlineImageView(in view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, imageView.bounds.height <= 1.0 {
            return imageView
        }

        for subview in view.subviews {
            if let imageView = self.hairlineImageView(in: subview) { return imageView }
        }

        return nil
    }
}
