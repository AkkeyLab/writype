//
//  EPExtensions.swift
//  writype
//
//  Created by 板谷晃良 on 2016/08/28.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

//MARK: - UIViewController Extensions

extension UIViewController {

    func showAlert(message: String) {
        showAlert(message, andTitle: "")
    }

    func showAlert(message: String, andTitle title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))

        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

//MARK: - UIColor Extensions

extension UIColor {
    class func defaultTintColor() -> UIColor {
        return UIColor(red: (233 / 255), green: (159 / 255), blue: (94 / 255), alpha: 1.0)
    }
}