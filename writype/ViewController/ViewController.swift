//
//  ViewController.swift
//  writype
//
//  Created by 金築良磨 on 2016/07/18.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EPSignatureDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func createFont(sender: AnyObject) {
        let signatureVC = CreateFontViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: true)
        let nav = UINavigationController(rootViewController: signatureVC)
        presentViewController(nav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

