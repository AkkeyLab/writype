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
    public var tintColor = UIColor.defaultTintColor() // バーアイテムの色変更はここで行う

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

//        if showsSaveSignatureOption {
//            let actionButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: #selector(CreateFontViewController.onTouchActionButton(_:)))
//            actionButton.tintColor = tintColor
//            self.navigationItem.rightBarButtonItems = [doneButton, clearButton, actionButton]
//        } else {
//            self.navigationItem.rightBarButtonItems = [doneButton, clearButton]
//        }
        self.navigationItem.rightBarButtonItems = [doneButton, clearButton]
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

    // 戻る操作に相当する
    func onTouchCancelButton() {
//        signatureDelegate?.epSignature!(self, didCancel: NSError(domain: "EPSignatureDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not signed"]))
        dismissViewControllerAnimated(true, completion: nil)
    }

    // 文字が書かれていれば前の画面に戻る動作を提供
    // 戻る動作を変更しつつ、左右の次の文字を押したときにここが呼ばれるように変更を行う
    func onTouchDoneButton() {
        if let signature = signatureView.getSignatureAsImage() {
            // ここが画像の保存部分。
//            if switchSaveSignature.on {
            let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
            let filePath = (docPath! as NSString).stringByAppendingPathComponent("sig.data")
            signatureView.saveSignature(filePath)
//            }
//            signatureDelegate?.epSignature!(self, didSign: signature, boundingRect: signatureView.getSignatureBoundsInCanvas())
            // 一時的に閉じないようにしている
//            dismissViewControllerAnimated(true, completion: nil)
            // とりあえず、ライブラリに保存する
            UIImageWriteToSavedPhotosAlbum(signatureView.getSignatureAsImage()!, self, nil, nil)
            signatureView.clear()
            showAlert("手書き文字の保存が完了しました", andTitle: "保存完了")
        } else {
            showAlert("全文字の入力が完了しておりません。作業を中断する場合はキャンセルを行ってください。", andTitle: "未完了")
        }
    }

//    func onTouchActionButton(barButton: UIBarButtonItem) {
//        let action = UIAlertController(title: "Action", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
//        action.view.tintColor = tintColor
//
//        action.addAction(UIAlertAction(title: "Load default signature", style: UIAlertActionStyle.Default, handler: { action in
//            let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
//            let filePath = (docPath! as NSString).stringByAppendingPathComponent("sig.data")
//            self.signatureView.loadSignature(filePath)
//            }))
//
//        action.addAction(UIAlertAction(title: "Delete default signature", style: UIAlertActionStyle.Destructive, handler: { action in
//            self.signatureView.removeSignature()
//            }))
//
//        action.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
//
//        if let popOver = action.popoverPresentationController {
//            popOver.barButtonItem = barButton
//        }
//        presentViewController(action, animated: true, completion: nil)
//    }

    // 文字の削除を行うボタンに割り当てる
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
