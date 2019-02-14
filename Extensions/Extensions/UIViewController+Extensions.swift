//
//  UIViewController+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    static var typeName: String {
        return String(describing: self)
    }
    
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func showAsyncActivityIndicator(in view: UIView, completion: @escaping (_ activityView: UIView) -> Void) {
        
        let indicatorView = UIView()
        indicatorView.frame = view.frame
        indicatorView.center = view.center
        indicatorView.backgroundColor = .clear
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = .black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.style = .whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(actInd)
        indicatorView.addSubview(loadingView)
        actInd.startAnimating()
        
        view.addSubview(indicatorView)
        completion(indicatorView)
    }
    
    func shakeView(_ viewToShake: UIView) {
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        var from_point: CGPoint = CGPoint(x: viewToShake.center.x - 5, y: viewToShake.center.y)
        var from_value: NSValue = NSValue(cgPoint: from_point)
        
        var to_point: CGPoint = CGPoint(x: viewToShake.center.x + 5, y: viewToShake.center.y)
        var to_value: NSValue = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        viewToShake.layer.add(shake, forKey: "position")
        
        from_point = CGPoint(x: viewToShake.center.x - 5, y: viewToShake.center.y)
        from_value = NSValue(cgPoint: from_point)
        
        to_point = CGPoint(x: viewToShake.center.x + 5, y: viewToShake.center.y)
        to_value = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        viewToShake.layer.add(shake, forKey: "position")
    }
    
    func setUpNavigationBar(_ title: String, prefersLargeTitles: Bool = true) {
        navigationController?.navigationBar.prefersLargeTitles = Device.isPad() ? prefersLargeTitles : false
        navigationController?.navigationBar.topItem?.title = title
    }
    
    func hideBackButton(_ hide: Bool) {
        navigationItem.setHidesBackButton(hide, animated: false)
    }
    
    func showAlert(_ title: String = "jsolalla", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCompletion(_ title: String = "jsolalla", message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized, style: UIAlertAction.Style.default, handler: { (_) -> Void in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCompletionOptions(_ title: String = "jsolalla", message: String, completion: @escaping (_ yes: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sí".localized, style: .default, handler: { (_) -> Void in
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler: { (_) -> Void in
            completion(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCompletionOptionsAndActions(_ title: String = "jsolalla", yesAction: String, noAction: String, message: String, completion: @escaping (_ yes: Bool) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        alert.addAction(UIAlertAction(title: yesAction, style: .default, handler: { (_) -> Void in
            completion(true)
        }))
        
        alert.addAction(UIAlertAction(title: noAction, style: .default, handler: { (_) -> Void in
            completion(false)
        }))
        
        present(alert, animated: true, completion: nil)
    }

    func startAnimation() {
        
        for animateView in getSubViewsForAnimate() {
            animateView.clipsToBounds = true
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
            gradientLayer.frame = animateView.bounds
            animateView.layer.mask = gradientLayer
            
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 1.5
            animation.fromValue = -animateView.frame.size.width
            animation.toValue = animateView.frame.size.width
            animation.repeatCount = .infinity
            
            gradientLayer.add(animation, forKey: "")
        }
    }
    
    func stopAnimation() {
        for animateView in getSubViewsForAnimate() {
            animateView.layer.removeAllAnimations()
            animateView.layer.mask = nil
        }
    }
    
    func getSubViewsForAnimate() -> [UIView] {
        var obj: [UIView] = []
        for objView in view.subviewsRecursive() {
            obj.append(objView)
        }
        return obj.filter({ (obj) -> Bool in
            obj.shimmerAnimation
        })
    }
    
}
