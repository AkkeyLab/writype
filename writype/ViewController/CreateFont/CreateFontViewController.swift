//
//  CreateFontViewController.swift
//  writype
//
//  Created by 金築良磨 on 2016/08/12.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

// MARK: - EPSignatureDelegate
@objc public protocol EPSignatureDelegate {
    optional func epSignature(_: CreateFontViewController, didCancel error: NSError)
    optional func epSignature(_: CreateFontViewController, didSign signatureImage: UIImage, boundingRect: CGRect)
}

public class CreateFontViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var signatureView: EPSignatureView!

    // MARK: - Public Vars
    public var showsDate: Bool = true
    public var showsSaveSignatureOption: Bool = true
    public weak var signatureDelegate: EPSignatureDelegate?
    public var subtitleText = "Sign Here"
    public var tintColor = UIColor.defaultTintColor()

    // MARK: - Life cycle methods
    override public func viewDidLoad() {
        super.viewDidLoad()

        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(CreateFontViewController.onTouchCancelButton))
        cancelButton.tintColor = tintColor
        self.navigationItem.leftBarButtonItem = cancelButton

        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(CreateFontViewController.onTouchDoneButton))
        doneButton.tintColor = tintColor
        let clearButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: #selector(CreateFontViewController.onTouchClearButton))
        clearButton.tintColor = tintColor

//        if showsDate {
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "dd MMMM YYYY"
//            lblDate.text = dateFormatter.stringFromDate(NSDate())
//        } else {
//            lblDate.hidden = false
//        }

        if showsSaveSignatureOption {
            let actionButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: #selector(CreateFontViewController.onTouchActionButton(_:)))
            actionButton.tintColor = tintColor
            self.navigationItem.rightBarButtonItems = [doneButton, clearButton, actionButton]
//            switchSaveSignature.onTintColor = tintColor
        } else {
            self.navigationItem.rightBarButtonItems = [doneButton, clearButton]
//            lblDefaultSignature.hidden = true
//            switchSaveSignature.hidden = true
        }

//        lblSignatureSubtitle.text = subtitleText
//        switchSaveSignature.setOn(false, animated: true)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Initializers

    public convenience init(signatureDelegate: EPSignatureDelegate) {
        self.init(signatureDelegate: signatureDelegate, showsDate: true, showsSaveSignatureOption: true)
    }

    public convenience init(signatureDelegate: EPSignatureDelegate, showsDate: Bool) {
        self.init(signatureDelegate: signatureDelegate, showsDate: showsDate, showsSaveSignatureOption: true)
    }

    public init(signatureDelegate: EPSignatureDelegate, showsDate: Bool, showsSaveSignatureOption: Bool) {
        self.showsDate = showsDate
        self.showsSaveSignatureOption = showsSaveSignatureOption
        self.signatureDelegate = signatureDelegate
        let bundle = NSBundle(forClass: CreateFontViewController.self)
        super.init(nibName: "EPSignatureViewController", bundle: bundle)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Button Actions

    func onTouchCancelButton() {
//        signatureDelegate?.epSignature!(self, didCancel: NSError(domain: "EPSignatureDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not signed"]))
        dismissViewControllerAnimated(true, completion: nil)
    }

    func onTouchDoneButton() {
        if let signature = signatureView.getSignatureAsImage() {
//            if switchSaveSignature.on {
//                let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
//                let filePath = (docPath! as NSString).stringByAppendingPathComponent("sig.data")
//                signatureView.saveSignature(filePath)
//            }
//            signatureDelegate?.epSignature!(self, didSign: signature, boundingRect: signatureView.getSignatureBoundsInCanvas())
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            showAlert("You did not sign", andTitle: "Please draw your signature")
        }
    }

    func onTouchActionButton(barButton: UIBarButtonItem) {
        let action = UIAlertController(title: "Action", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        action.view.tintColor = tintColor

        action.addAction(UIAlertAction(title: "Load default signature", style: UIAlertActionStyle.Default, handler: { action in
            let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
            let filePath = (docPath! as NSString).stringByAppendingPathComponent("sig.data")
            self.signatureView.loadSignature(filePath)
            }))

        action.addAction(UIAlertAction(title: "Delete default signature", style: UIAlertActionStyle.Destructive, handler: { action in
            self.signatureView.removeSignature()
            }))

        action.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))

        if let popOver = action.popoverPresentationController {
            popOver.barButtonItem = barButton
        }
        presentViewController(action, animated: true, completion: nil)
    }

    func onTouchClearButton() {
        signatureView.clear()
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}