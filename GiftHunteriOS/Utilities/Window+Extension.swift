//
//  Window+Extension.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import UIKit
import FirebaseCrashlytics

#if DEBUG
extension UIWindow {
    override open func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let alertView = UIAlertController(title: "Tools", message: nil, preferredStyle: .actionSheet)
            let mockCrashAction = UIAlertAction(title: "Mock Crash", style: .default, handler: { _ in
                Crashlytics.crashlytics().setUserID("user_id")
                fatalError("Force crash for testing crashlytics")
            })
            let openWebKit = UIAlertAction(title: "Web Kit Test", style: .default, handler: { _ in
                self.rootViewController?.present(WebViewController(), animated: true)
            })
            
            alertView.addAction(mockCrashAction)
            alertView.addAction(openWebKit)
            rootViewController?.present(alertView, animated: true, completion: {
                guard let rootView = alertView.view.superview?.subviews[0] else { return }
                rootView.isUserInteractionEnabled = true
                rootView.addGestureRecognizer(
                    UITapGestureRecognizer(
                        target: self,
                        action: #selector(self.dismissOnTapOutside)
                    )
                )
            })
        }
    }
    
    @objc private func dismissOnTapOutside() {
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
#endif
