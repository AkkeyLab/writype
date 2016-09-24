//
//  CreateReportViewController.swift
//  writype
//
//  Created by 金築良磨 on 2016/08/12.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class CreateReportViewController: UIViewController {

    @IBOutlet weak var reportText: UITextView!
    var saveText = ""
    @IBAction func previewButton(sender: AnyObject) {
    }
   
  
    @IBAction func deleteButton(sender: AnyObject) {
        reportText.text = ""
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        saveText = reportText.text
    }
   
    @IBAction func refreshButton(sender: AnyObject) {
        reportText.text = saveText
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportText.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var previewViewController = segue.destinationViewController as! PreviewViewController
        previewViewController.text1 = reportText.text
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
