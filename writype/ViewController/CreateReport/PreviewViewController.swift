//
//  PreviewViewController.swift
//  writype
//
//  Created by 金築良磨 on 2016/09/22.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
   
    var text1: String?
    
    var imageView:UIImageView!
    
    //各画像の幅、高さ
    var imageWidth:CGFloat = 0
    var imageHeight:CGFloat = 0
    
    //描画した幅、高さ
    var totalWidth:CGFloat = 50
    var totalHeight:CGFloat = 200
    
    
    var scale:CGFloat = 0.3 //拡大,縮小比率
    var imageBetweenWidth:CGFloat = -20 //文字間の幅
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lowertext = text1?.lowercaseString //小文字に変換
        let characters = lowertext?.characters.map { String($0) } // String -> [String]
        
        let countString:Int = (text1?.characters.count)!
        for i in 0..<countString {
            switch characters![i] {
            case " ":
                totalWidth += 30
            case "\n":
                totalWidth = 50
                totalHeight += 50
            default:
                initImageView("alphabet/" + characters![i] + ".jpg")
            }
        }
    }
    
    @IBAction func zoomUpButton(sender: AnyObject) {
        scale += 0.02
        
//        let view: UIImageView = UIImageView()
//        view.removeFromSuperview()
        
        viewDidLoad()
        
    }
    
    //画像を配置する場所の更新
    func updateImageLocation(imgWidth:CGFloat,imgHeight:CGFloat) {
        totalWidth += imageWidth
        totalHeight += imageHeight
    }
    
    
    private func initImageView(img:String){
        // UIImage インスタンスの生成
        let image1:UIImage = UIImage(named:img)!
        
        // UIImageView 初期化
        let imageView = UIImageView(image:image1)
        
        // 画像の幅・高さの取得
        imageWidth = image1.size.width - 20
        imageHeight = image1.size.height
        
        //画像サイズ
        let rect:CGRect = CGRect(x:0, y:0, width:imageWidth * scale, height:imageHeight * scale)
        imageView.frame = rect
        
        
        
        // 画面の横幅を取得
        let screenWidth:CGFloat = view.frame.size.width
//        let screenHeight:CGFloat = view.frame.size.height
        
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:totalWidth, y:totalHeight)
        //imageView.contentMode = UIViewContentMode.Bottom
        
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        
        totalWidth += imageWidth * scale + imageBetweenWidth
        if(totalWidth > screenWidth){
            totalWidth = 50
            totalHeight += imageHeight * scale + 10
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
