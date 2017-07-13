//
//  UIImage+shadowImage.swift
//
//  Created by Ilya Kharabet on 25.11.16.
//  Copyright © 2016 IK. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    class func shadowImage(with color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
}
