//
//  UIViewController+Loading.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 14.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit


extension UIViewController {

    func showLoading() {
        if !isLoading {
            let loadingView = LoadingView(frame: CGRect(x: view.center.x - 36, y: view.center.y - 80, width: 72, height: 72))
            view.addSubview(loadingView)
            view.bringSubview(toFront: loadingView)
        }
    }
    
    func hideLoading() {
        if isLoading {
            view.subviews.filter { $0 is LoadingView }.forEach { $0.removeFromSuperview() }
        }
    }
    
    fileprivate var isLoading: Bool {
        return view.subviews.contains(where: { $0 is LoadingView })
    }

}

final class LoadingView: UIView {
    
    fileprivate var activityIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor.darkGray.withAlphaComponent(0.90).cgColor
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        bringSubview(toFront: activityIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicator.center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
    }

}
