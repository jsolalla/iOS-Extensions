//
//  UIApplication+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import Foundation
import UIKit

fileprivate let feedbackGenerator: (notification: UINotificationFeedbackGenerator, impact: (light: UIImpactFeedbackGenerator, medium: UIImpactFeedbackGenerator, heavy: UIImpactFeedbackGenerator), selection: UISelectionFeedbackGenerator) = {
    return (notification: UINotificationFeedbackGenerator(), impact: (light: UIImpactFeedbackGenerator(style: .light), medium: UIImpactFeedbackGenerator(style: .medium), heavy: UIImpactFeedbackGenerator(style: .heavy)), selection: UISelectionFeedbackGenerator())
}()

public func delay(seconds: Double, completion: @escaping () -> Void) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}

public extension UIApplication {
    
    enum Feedback {
        case success
        case warning
        case error
        case light
        case medium
        case heavy
        case selection
    }

    func feedback(_ feedback: Feedback) {
        
        switch feedback {
        case .success:
            feedbackGenerator.notification.notificationOccurred(.success)
        case .warning:
            feedbackGenerator.notification.notificationOccurred(.warning)
        case .error:
            feedbackGenerator.notification.notificationOccurred(.error)
        case .light:
            feedbackGenerator.impact.light.impactOccurred()
        case .medium:
            feedbackGenerator.impact.medium.impactOccurred()
        case .heavy:
            feedbackGenerator.impact.heavy.impactOccurred()
        case .selection:
            feedbackGenerator.selection.selectionChanged()
        }
        
    }
    
}
