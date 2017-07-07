//
//  HardCodeViewController.swift
//  PrisonerManagement
//
//  Created by 李佳駿 on 2017/7/3.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit

class HardCodeViewController: UIViewController {

      let PINCODE:String = "123456"
    
    @IBAction func SignUpBtn(_ sender: Any)
    {
        //PinCodeText不等於PINCODE或PinCodeText==空值就return不進行頁面跳轉
        if PinCodeText.text == "" || PinCodeText.text != PINCODE
        {
            return
        }
        //當PinCodeText==PINCODE就進行頁面跳轉
        if PinCodeText.text == PINCODE
        {
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let MenuVC = storyboard.instantiateViewController(withIdentifier: "Menu")
            self.present(MenuVC, animated: true, completion: nil)
            
            
        }

        
    }
    @IBAction func VerifyBtn(_ sender: Any)
    {
        print("有")
    }
    @IBAction func CancerBtn(_ sender: Any)
    {
        //返回上一頁
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet var PinCodeText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //數字鍵盤
        self.PinCodeText.keyboardType = .numberPad
    }

    //取消鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.PinCodeText.resignFirstResponder()
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
