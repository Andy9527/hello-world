//
//  RcordViewController.swift
//  CarCare
//
//  Created by 李佳駿 on 2017/3/31.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class RcordViewController: UIViewController{

    //MARK:- 屬性宣告
    var consumption:String = ""
    var oilMoney:String = ""
    var milageString:String = ""
    var dateTapGes:UITapGestureRecognizer!
    var datePicker:UIDatePicker!
    var dateAlert:UIAlertController!
    var entity:Record? = nil
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityDis:NSEntityDescription!
    var entityName:String = "Record"
    
    //MARK:- 物件連結
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var oilPrice: UITextField!
    @IBOutlet var milageText: UITextField!
    @IBOutlet var literText: UITextField!
    //MARK:- SaveButton
    
   
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNumberPad()
        
        
        let image = UIImage(named: "save.png")
        let button:UIButton = UIButton.init(type: .custom)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        button.addTarget(self, action: #selector(save), for: UIControlEvents.touchUpInside)
        let barbutton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barbutton

        
        
        dateTapGes = UITapGestureRecognizer(target: self, action:#selector(showDateAlert))
        dateTapGes.numberOfTapsRequired = 1
        self.dateLabel.addGestureRecognizer(dateTapGes)
        dateLabel.isUserInteractionEnabled = true
        
        self.dateLabel.text = "日期時間:" + showDateString(Date())
        
        if entity != nil
        {
        self.literText.text = entity?.liter
        self.oilPrice.text = entity?.price
        self.dateLabel.text = "日期時間:" + (entity?.date)!
        self.milageText.text = entity?.milage
        }
        if entity != nil
        {
            self.navigationItem.title = "編輯資料"
        }else
        {
            self.navigationItem.title = "新增資料"
        }
        
    }

    // 顯示螢幕提示
    func animationView(_ showTitle: String) {
        // 建立 UILabel
        let width = UIScreen.main.bounds.width
        let titleText: UILabel = UILabel(frame: CGRect(x: 0 , y: 0-60, width: width, height: 60))
        // 設定文字、字型、不透明度、對齊方式
        titleText.text = showTitle
        titleText.font = UIFont(name: "Chalkduster", size: 18)
        titleText.textColor = UIColor.white
        titleText.backgroundColor = UIColor.black
        
        // 設定透明度、位置
        titleText.alpha = 1
        titleText.textAlignment = NSTextAlignment.center
        
        // 加入畫面
        //self.view.addSubview(titleText)
        navigationController?.view.addSubview(titleText)
        
        // 利用 UIView 的 animateWithDuration 執行動畫
        UIView.animate(withDuration: 0.3, animations: {
            // 第一階段動畫
            titleText.tintColor = UIColor.orange
            titleText.alpha = 1.0
            titleText.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        }, completion: {
            (value: Bool) in
            UIView.animate(withDuration: 3, delay: 0.5,
                           options: UIViewAnimationOptions(), animations: {
                            // 第二階段動畫
                            titleText.alpha = 0.0
            }, completion: {
                (value: Bool) in
                // 動畫完成，移除元件
                titleText.removeFromSuperview()
            })
        })
        
    }

    func save()
    {
        if milageText.text == ""
        {
            self.animationView("請輸入目前總里程數")
            return
        }else
        {
            let liter2 = Float(self.literText.text!)
            let oilPrice2 = Float(self.oilPrice.text!)
            let oilMoney = String(liter2! * oilPrice2!)
            self.oilMoney = oilMoney
            let NowMilage = Float(self.milageText.text!)
            let LastTimeMilage = Float(self.milageString)
            let milage = NowMilage! - LastTimeMilage!
            let cunsomption = String((liter2! / milage) * 100)
            self.consumption = cunsomption
        }
        if literText.text == ""
        {
            self.animationView("請輸入本次加油公升數")
            return
        }else
        {
            let liter2 = Float(self.literText.text!)
            let oilPrice2 = Float(self.oilPrice.text!)
            let oilMoney = String(liter2! * oilPrice2!)
            self.oilMoney = oilMoney
            let NowMilage = Float(self.milageText.text!)
            let LastTimeMilage = Float(self.milageString)
            let milage = NowMilage! - LastTimeMilage!
            let cunsomption = String((liter2! / milage) * 100)
            self.consumption = cunsomption
        }
        
        if oilPrice.text == ""
        {
            self.animationView("請輸入目前油價")
            return
        }else
        {
            let liter2 = Float(self.literText.text!)
            let oilPrice2 = Float(self.oilPrice.text!)
            let oilMoney = String(liter2! * oilPrice2!)
            self.oilMoney = oilMoney
            let NowMilage = Float(self.milageText.text!)
            let LastTimeMilage = Float(self.milageString)
            let milage = NowMilage! - LastTimeMilage!
            let cunsomption = String((liter2! / milage) * 100)
            self.consumption = cunsomption
        }
        
        
        if entity != nil
        {
            edit()
        }else
        {
            createNewTable()
        }
        dismissVC()

    }
    //螢幕旋轉
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate : Bool {
        return true
    }

    //MARK:- dismissVC
    func dismissVC()
    {
        _  = navigationController?.popViewController(animated: true)
    }
    //MARK:- createNewTable
    func createNewTable()
    {
        entityDis = NSEntityDescription.entity(forEntityName: entityName, in: context)
        entity = Record(entity: entityDis, insertInto: context)
        entity?.date = self.dateLabel.text!
        entity?.price = self.oilPrice.text!
        entity?.liter = self.literText.text!
        entity?.money = self.oilMoney
        entity?.milage = self.milageText.text!
        entity?.consumption = self.consumption
        try! context.save()
        
    }
    //MARK:- editTable
    func edit()
    {
        entity?.date = self.dateLabel.text!
        entity?.price = self.oilPrice.text!
        entity?.liter = self.literText.text!
        entity?.money = self.oilMoney
        entity?.milage = self.milageText.text!
        entity?.consumption = self.consumption
        try! context.save()
  
    }
    
    //MARK:- 取消鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.milageText.resignFirstResponder()
        self.oilPrice.resignFirstResponder()
        self.literText.resignFirstResponder()
    }

    //MARK:- 數字鍵盤及字型大小
    func showNumberPad()
    {
        self.literText.keyboardType = .numbersAndPunctuation
        self.milageText.keyboardType = .numberPad
        self.oilPrice.keyboardType = .numbersAndPunctuation
        self.literText.font = UIFont(name: "Helvetica", size: 16.0)
        self.milageText.font = UIFont(name: "Helvetica", size: 16.0)
        self.oilPrice.font = UIFont(name: "Helvetica", size: 16.0)
        self.literText.placeholder = "請輸入公升數"
        self.milageText.placeholder = "請輸入目前總里程數"
        self.oilPrice.placeholder = "請輸入目前油價"
    }

    //MARK:- 時間轉字串
    func showDateString(_ date:Date) -> String
    {
        let dateFMT:DateFormatter = DateFormatter()
        dateFMT.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFMT.string(from: date)
        return dateString
        
    }
    //MARK:- DatePicker
    func showDateAlert()
    {
        
        let rect = CGRect(x: 0.0, y: 40, width: 400, height: 180)
        datePicker = UIDatePicker(frame: rect)
        datePicker.datePickerMode = .dateAndTime
        
        
        dateAlert = UIAlertController(title: "請選擇時間", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        dateAlert.view.addSubview(datePicker)
        
        let action1:UIAlertAction = UIAlertAction(title: "確定", style: .default) { (action) in
            self.dateLabel.text = self.showDateString(self.datePicker.date)
        }
        dateAlert.addAction(action1)
        let action2:UIAlertAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        dateAlert.addAction(action2)
        
        self.present(dateAlert, animated: true, completion: nil)
        
        
        
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
