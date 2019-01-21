//
//  extension.swift
//  Test Navigation
//
//  Created by Marius Lazar on 17/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit

extension UIColor
{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: CGFloat(r / 255), green: CGFloat(g / 255), blue: CGFloat(b / 255), alpha: CGFloat(1))
    }
}

extension UIView{
    
    func showBlurLoader()
    {
        let viewBlack = UIView()
        viewBlack.backgroundColor = .black
        viewBlack.frame = self.frame
        viewBlack.alpha = 0.6
        viewBlack.tag = 10
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activity.startAnimating()
        activity.center = viewBlack.center
        viewBlack.addSubview(activity)
        self.addSubview(viewBlack)
        
        for subview in self.subviews
        {
            if subview.tag == 10
            {
                return
            }
        }

    }
    
    func removeBluerLoader()
    {
        let activity = self.viewWithTag(10)
        activity?.removeFromSuperview()

    }
}

extension UINavigationController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
