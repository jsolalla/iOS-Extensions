//
//  UIView+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import UIKit

var associateObjectValue: Int = 0

public extension UIView {
    
    @IBInspectable var shimmerAnimation: Bool {
        get {
            return isAnimate
        }
        set {
            self.isAnimate = newValue
        }
    }
    
    fileprivate var isAnimate: Bool {
        get {
            return objc_getAssociatedObject(self, &associateObjectValue) as? Bool ?? false
        }
        set {
            return objc_setAssociatedObject(self, &associateObjectValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.fillColor = UIColor.white.cgColor
        layer.mask = mask
        return mask
    }
    
    func _roundMask(corners: UIRectCorner, radius: CGFloat) {
        
        if layer.mask == nil {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            mask.fillColor = UIColor.white.cgColor
            layer.mask = mask
        }
        
    }
    
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func dropShadow(radius: CGFloat = 10) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.10
        layer.shadowOffset = .zero
        layer.shadowRadius = 2.2
        layer.rasterizationScale = 1
    }
    
    func pressView() {
        UIView.animate(withDuration: 0.08, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
        }) { _ in
            UIApplication.shared.feedback(.light)
        }
    }
    
    func releaseView() {
        UIView.animate(withDuration: 0.08) {
            self.transform = .identity
        }
    }
    
    func simulateTap() {
        pressView()
        delay(seconds: 0.2) {
            self.releaseView()
        }
    }
    
    func rotate(duration: CFTimeInterval = 5.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        layer.add(rotateAnimation, forKey: nil)
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func addTopBorder(_ color: UIColor?, borderWidth: CGFloat = CGFloat(1)) {
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth))
        newView.backgroundColor = color
        addSubview(newView)
        
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth]
    }
    
    func addBottomBorder(_ color: CGColor?, borderWidth: CGFloat = CGFloat(1)) {
        let border = CALayer()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorder(color: CGColor?, borderWidth: CGFloat = CGFloat(1)) {
        let border = CALayer()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addRightBorder(color: CGColor?, borderWidth: CGFloat = CGFloat(1)) {
        let border = CALayer()
        border.backgroundColor = color
        border.frame = CGRect(x: self.frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        layer.addSublayer(border)
    }
    
    func addMiddleBorder(color: CGColor?, borderWidth: CGFloat = CGFloat(1)) {
        let border = CALayer()
        border.backgroundColor = color
        border.frame = CGRect(x: (self.frame.size.width - borderWidth) / 2, y: 0, width: borderWidth, height: frame.size.height)
        layer.addSublayer(border)
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
}
