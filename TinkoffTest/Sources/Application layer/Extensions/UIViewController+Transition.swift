//
//  UIViewController+Transition.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 14.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit


public protocol TransitionHandler: class {
    func pushModule(with viewController: UIViewController, animated: Bool)
    func presentModule(with viewController: UIViewController, animated: Bool)
}

public extension TransitionHandler where Self: UIViewController {
    func pushModule(with viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            if let parentNavigationController = self.parent as? UINavigationController {
                parentNavigationController.pushViewController(viewController, animated: animated)
            } else if let navigationController = self as? UINavigationController {
                navigationController.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    func presentModule(with viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.present(viewController, animated: animated, completion: nil)
        }
    }
}
