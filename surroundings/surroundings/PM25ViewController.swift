//
//  PM25ViewController.swift
//  surroundings
//
//  Created by 李佳駿 on 2016/11/7.
//  Copyright © 2016年 李佳駿. All rights reserved.
//

import UIKit

class PM25ViewController: UIViewController {
    
    var text = ""
    var text2 = ""

    @IBOutlet var label: UILabel!
    @IBOutlet var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.font = UIFont(name: "Helvetica", size: 16.0)
        label.text = text
        label2.font = UIFont(name: "Helvetica", size: 16.0)
        label2.text = text2
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
