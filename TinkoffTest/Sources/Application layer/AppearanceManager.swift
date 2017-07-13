//
//  AppearanceManager.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit


final class AppearanceManager {

    static func applyTheme() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor("FFE817")
        navigationBar.tintColor = UIColor("0D0D0D")
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 21),
            NSForegroundColorAttributeName: UIColor("0D0D0D")
        ]
        navigationBar.shadowImage = UIImage.shadowImage(with: UIColor("534B04"))
    }

}
