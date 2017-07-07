//
//  SignViewController.swift
//  PrisonerManagement
//
//  Created by 李佳駿 on 2017/7/3.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {

    let EmialString:String = "a123456@gmail.com"
    let PasswordString:String = "123456"
    
    @IBOutlet var PasswordText: UITextField!
    @IBAction func RegisterBtn(_ sender: Any)
    {
        //當EmailText是空值或不等於EmailString就return不進行頁面跳轉
        if EmailText.text != EmialString || EmailText.text == ""
        {
            return
            
        }
        //當PasswordText是空值或不等於PasswordString就return不進行頁面跳轉
        if PasswordText.text != PasswordString || PasswordText.text == ""
        {
            
            return
            
        }
        //當EmailText==EmailString以及PasswordText==PasswordString就進行頁面跳轉
        if EmailText.text == EmialString && PasswordText.text == PasswordString
        {
            
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let HardCodeVC = storyboard.instantiateViewController(withIdentifier: "HardCode")
            self.present(HardCodeVC, animated: true, completion: nil)
            
            
        }

        
        
    }
    @IBOutlet var EmailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //鍵盤樣式
        self.EmailText.keyboardType = .emailAddress
        self.PasswordText.keyboardType = .numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //取消鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.EmailText.resignFirstResponder()
        self.PasswordText.resignFirstResponder()
        
    }

    //隱藏狀態列
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    //螢幕旋轉
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate : Bool {
        return true
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
