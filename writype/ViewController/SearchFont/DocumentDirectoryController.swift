//
//  DocumentDirectoryController.swift
//  writype
//
//  Created by 板谷晃良 on 2016/11/25.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

extension CreateFontViewController {

    func saveImageDocumentDirectory(name: String, image: UIImage) {
        let fileManager = NSFileManager.defaultManager()
        let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent(name + ".jpg")
        print(paths)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFileAtPath(paths as String, contents: imageData, attributes: nil)
    }

    func getImage(name: String) -> UIImage {
        var outputImage: UIImage = UIImage(named: "alphabet/" + name + ".jpg")!

        let fileManager = NSFileManager.defaultManager()
        let imagePAth = (self.getDirectoryPath() as NSString).stringByAppendingPathComponent(name + ".jpg")
        if fileManager.fileExistsAtPath(imagePAth) {
            outputImage = UIImage(contentsOfFile: imagePAth)!
        } else {
            print("No Image")
        }

        return outputImage
    }

    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
