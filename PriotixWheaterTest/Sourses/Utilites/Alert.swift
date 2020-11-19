//
//  Alert.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit
fileprivate let alertTag = 123
class Alert {
    
    static func showAlert(_ title: String, message:String? = nil, positiveActionTitle: String = "OK", negativeActionTitle: String? = nil, negativeHandler:(()->Void)? = nil, handler:(()->Void)? = nil) {
        guard Utils.topViewController()?.view.tag != alertTag else {return}
        let alert = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: positiveActionTitle, style: .default) { (action) in
            handler? ()
        }
        
        alert.addAction(okAction)
        alert.view.tag = alertTag
        if let cancelActionTitle = negativeActionTitle {
            let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel) { (action) in
                negativeHandler?()
            }
            alert.addAction(cancelAction)
        }
        
        alert.show()
    }
    
}

extension UIAlertController {
    
    func show() {
        present(animated: true, completion: nil)
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        if let rootVC = Utils.topViewController() {
            presentFromController(controller: rootVC, animated: animated, completion: completion)
        }
    }
    
    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(controller: visibleVC, animated: animated, completion: completion)
        } else {
            if  let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(controller: selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion)
            }
        }
    }
}
