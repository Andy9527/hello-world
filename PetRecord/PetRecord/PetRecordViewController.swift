//
//  PetRecordViewController.swift
//  PetRecord
//
//  Created by 李佳駿 on 2017/3/8.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class PetRecordViewController: UIViewController {

    @IBAction func camera(_ sender: Any) {
        
        //建立UIImagePickerController物件
        let pickerController = UIImagePickerController()
        //設定代理器
        pickerController.delegate = self
        //設定樣式
        pickerController.sourceType = .photoLibrary
        //允許編輯
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
        print("點擊")
    }
    @IBAction func albun(_ sender: Any) {
        
        //建立UIImagePickerController物件
        let pickerController = UIImagePickerController()
        //設定代理器
        pickerController.delegate = self
        //設定樣式
        pickerController.sourceType = .photoLibrary
        //允許編輯
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
        print("點擊")
    }
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var money: UITextField!
    @IBOutlet var place: UITextField!
    @IBOutlet var medical: UITextField!
    @IBOutlet var name: UITextField!
    
        
    
    //屬性宣告
    var entityName:String = "Health"
    var entity:Health? = nil
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityDis:NSEntityDescription!
    var dateGes:UITapGestureRecognizer!
    var dateAlert:UIAlertController!
    var datePicker:UIDatePicker!
    
        
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let image = UIImage(named: "save.png")
        let button:UIButton = UIButton.init(type: .custom)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        button.addTarget(self, action: #selector(save), for: UIControlEvents.touchUpInside)
        let barbutton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barbutton

        
        
        self.money.keyboardType = .numberPad
        self.imageView.image = UIImage(named: "QBoy.png")
        //觸控物件
        dateGes = UITapGestureRecognizer(target: self, action: #selector(showDateSelector(_:)))
        dateGes.numberOfTapsRequired = 1
        date.addGestureRecognizer(dateGes)
        date.isUserInteractionEnabled = true
        
        self.date.text = self.showDateString(Date())
        
        if entity != nil
        {
            date.text = entity?.date
            money.text = entity?.money
            place.text = entity?.place
            name.text = entity?.name
            imageView.image = UIImage(data:(entity?.image)! as Data)
            medical.text = entity?.medical
            try! context.save()
            
        }
        if entity != nil
        {
            self.navigationItem.title = "編輯資料"
        }else
        {
            self.navigationItem.title = "新增資料"
        }
        
    }
    func save()
    {
        
        if self.name.text == ""
        {
            animationView("請輸入寵物名字")
            return
        }
        if self.medical.text == ""
        {
            animationView("請輸入保健項目")
            return
        }
        if self.place.text == ""
        {
            animationView("請輸入保健地點")
            return
        }
        if self.money.text == ""
        {
            animationView("請輸入保健金額")
            return
        }

        
        
        if entity != nil
        {
            edit()
        }else
        {
            create()
        }
        
        dismiss()
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

    
    //螢幕旋轉
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    //取消鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.name.resignFirstResponder()
        self.money.resignFirstResponder()
        self.place.resignFirstResponder()
        self.medical.resignFirstResponder()
    }

    
    
    //編輯
    func edit()
    {
        
        entity?.name = name.text
        entity?.date = date.text
        entity?.medical = medical.text
        entity?.money = money.text
        entity?.place = place.text
        entity?.image = UIImagePNGRepresentation(imageView.image!)! as NSData?
        try! context.save()
        
    }
    //新增
    func create()
    {
        entityDis = NSEntityDescription.entity(forEntityName: entityName, in: context)
        entity = Health(entity: entityDis, insertInto: context)
        
        entity?.name = name.text
        entity?.date = date.text
        entity?.medical = medical.text
        entity?.money = money.text
        entity?.place = place.text
        entity?.image = UIImagePNGRepresentation(imageView.image!)! as NSData?
        try! context.save()
        
        
    }
    //返回上一頁
    func dismiss()
    {
        _ = navigationController?.popViewController(animated: true)
    }
    //時間轉字串
    func showDateString(_ date:Date) -> String
    {
        //建立時間格式物件
        let dateFMT:DateFormatter = DateFormatter()
        dateFMT.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFMT.string(from: date)
        
        return dateString
        
    }
    //顯示UIAlertController
    func showDateSelector(_ sender:UITapGestureRecognizer)
    {
        //UIAlert物件
        dateAlert = UIAlertController(title: "請選擇時間", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        //DatePicker物件
        let rect = CGRect(x: 5, y: 40, width: 400, height: 180)
        datePicker = UIDatePicker(frame: rect)
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        dateAlert.view.addSubview(datePicker)
        //建立UIAlertAction
        let action1:UIAlertAction = UIAlertAction(title: "確定", style: .default) { (action) in
            self.date.text = self.showDateString(self.datePicker.date)
        }
        dateAlert.addAction(action1)
        let action2:UIAlertAction = UIAlertAction(title:"取消", style: .cancel) { (action) in
            print("取消")
        }
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
extension PetRecordViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.imageView.image = image
        
        
    }
    
    
    
    
    
    
}



