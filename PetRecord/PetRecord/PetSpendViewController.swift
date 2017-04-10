//
//  PetSpendViewController.swift
//  PetRecord
//
//  Created by 李佳駿 on 2017/3/8.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class PetSpendViewController: UIViewController {

    
     //屬性宣告
     var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     var entityName = "Spend"
     var entity:Spend? = nil
     var entityDis:NSEntityDescription!
     var dateTapGes:UITapGestureRecognizer!
     var datePicker:UIDatePicker!
     var dateAlert:UIAlertController!
    
    @IBAction func album(_ sender: Any) {
        //相機物件
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func camera(_ sender: Any) {
        //相簿物件
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var moneyField: UITextField!
    @IBOutlet var placeField: UITextField!
    @IBOutlet var nameField: UITextField!
   
    func save()
    {
        
        if self.nameField.text == ""
        {
            animationView("請輸入項目")
            return
        }
        if self.placeField.text == ""
        {
            animationView("請輸入地點")
            return
        }
        if self.moneyField.text == ""
        {
            animationView("請輸入金額")
            return
        }

        
        if entity != nil
        {
            edit()
        }else
        {
            create()
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

    //取消鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameField.resignFirstResponder()
        self.moneyField.resignFirstResponder()
        self.placeField.resignFirstResponder()
    }
    //返回上一頁
    func dismissVC()
    {
        
        _ = navigationController?.popViewController(animated: true)
    }
    //建立資料表
    func create()
    {
        entityDis = NSEntityDescription.entity(forEntityName: entityName, in: context)
        entity = Spend(entity: entityDis, insertInto: context)
        entity?.name = self.nameField.text
        entity?.place = self.placeField.text
        entity?.money = self.moneyField.text
        entity?.date = self.dateLabel.text
        entity?.image = UIImagePNGRepresentation(self.imageView.image!)! as NSData?
        try! context.save()
        
    }
    //編輯資料表
    func edit()
    {
        entity?.name = self.nameField.text
        entity?.place = self.placeField.text
        entity?.money = self.moneyField.text
        entity?.date = self.dateLabel.text
        entity?.image = UIImagePNGRepresentation(self.imageView.image!)! as NSData?
        try! context.save()
    }
    func showDateString(_ date:Date) -> String
    {
        let dateFMT:DateFormatter = DateFormatter()
        dateFMT.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFMT.string(from: date)
        return dateString
    
    }
    func showDateSelector(_ sender:UITapGestureRecognizer)
    {
        let rect = CGRect(x: 5, y: 40, width: 400, height: 180)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "save.png")
        let button:UIButton = UIButton.init(type: .custom)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        button.addTarget(self, action: #selector(save), for: UIControlEvents.touchUpInside)
        let barbutton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barbutton

        
        self.navigationItem.title = "寵物花費紀錄"
        self.moneyField.keyboardType = .numberPad
        //預設圖片
        self.imageView.image = UIImage(named: "QBoy.png")
        //預設時間
        self.dateLabel.text = self.showDateString(Date())
        
        dateTapGes = UITapGestureRecognizer(target: self, action: #selector(showDateSelector(_:)))
        dateTapGes.numberOfTapsRequired = 1
        self.dateLabel.addGestureRecognizer(dateTapGes)
        dateLabel.isUserInteractionEnabled = true
        
        
        if entity != nil
        {
        self.nameField.text = self.entity?.name
        self.moneyField.text = self.entity?.money
        self.placeField.text = self.entity?.place
        self.dateLabel.text = self.entity?.date
        self.imageView.image = UIImage(data: (self.entity?.image)! as Data)
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
extension PetSpendViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.imageView.image = image
      }
    
    
}




