//
//  WarrantyViewController.swift
//  CarCare
//
//  Created by 李佳駿 on 2017/3/31.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class WarrantyViewController: UIViewController {

    //MARK:- 屬性宣告
    var dateAlert:UIAlertController!
    var pickerAlert:UIAlertController!
    var pickerString:String = ""
    var pickerArr:[String] = []
    var pickerTapGes:UITapGestureRecognizer!
    var pickerView:UIPickerView!
    var dateTapGes:UITapGestureRecognizer!
    var datePicker:UIDatePicker!
    
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityDis:NSEntityDescription!
    var entityName:String = "Warranty"
    var entity:Warranty? = nil
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var moneyText: UITextField!
    @IBOutlet var placeText: UITextField!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var typeLabel: UILabel!
    
    @IBAction func album(_ sender: Any) {
        //建立UIImagePickerController物件
        let pickerController = UIImagePickerController()
        //設定代理器
        pickerController.delegate = self
        //設定樣式
        pickerController.sourceType = .photoLibrary
        //允許編輯
        pickerController.allowsEditing = true
        //推送畫面
        self.present(pickerController, animated: true, completion: nil)
        
        
        
    }
    @IBAction func camera(_ sender: Any) {
        //建立UIImagePickerController物件
        let pickerController = UIImagePickerController()
        //設定代理器
        pickerController.delegate = self
        //設定樣式
        pickerController.sourceType = .photoLibrary
        //允許編輯
        pickerController.allowsEditing = true
        //推送畫面
        self.present(pickerController, animated: true, completion: nil)
        
        
    }
    func save()
    {
        
        if nameText.text == ""
        {
            animationView("請輸入花費項目")
            return
        }
        if placeText.text == ""
        {
            animationView("請輸入花費地點")
            return
        }
        if moneyText.text == ""
        {
            animationView("請輸入花費金額")
            return
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
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let image = UIImage(named: "save.png")
        let button:UIButton = UIButton.init(type: .custom)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        button.addTarget(self, action: #selector(save), for: UIControlEvents.touchUpInside)
        let barbutton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barbutton

        
        pickerArr.append("保養")
        pickerArr.append("維修")
        
        showNumberPad()
        
        pickerTapGes = UITapGestureRecognizer(target: self, action: #selector(showPickerView))
        pickerTapGes.numberOfTapsRequired = 1
        typeLabel.addGestureRecognizer(pickerTapGes)
        typeLabel.isUserInteractionEnabled = true
        dateTapGes = UITapGestureRecognizer(target: self, action:#selector(showDateAlert))
        dateTapGes.numberOfTapsRequired = 1
        self.dateLabel.addGestureRecognizer(dateTapGes)
        dateLabel.isUserInteractionEnabled = true
        
        self.dateLabel.text = showDateString(Date())
        self.typeLabel.text = pickerArr[0]
        
        if entity != nil
        {
        self.dateLabel.text = entity?.date
        self.nameText.text = entity?.name
        self.typeLabel.text = entity?.style
        self.placeText.text = entity?.place
        self.moneyText.text = entity?.money
        self.imageView.image = UIImage(data: entity?.image as! Data)
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
    
    //MARK:- dismissVC
    func dismissVC()
    {
        _  = navigationController?.popViewController(animated: true)
    }

    //MARK:- createNewTable
    func createNewTable()
    {
        entityDis = NSEntityDescription.entity(forEntityName: entityName, in: context)
        entity = Warranty(entity: entityDis, insertInto: context)
        entity?.place = self.placeText.text!
        entity?.date = self.dateLabel.text!
        entity?.money = self.moneyText.text!
        entity?.style = self.typeLabel.text!
        entity?.name = self.nameText.text!
        entity?.image = UIImagePNGRepresentation(self.imageView.image!)! as NSData?
        try! context.save()
        
    }
    //MARK:- editTable
    func edit()
    {
        entity?.date = self.dateLabel.text!
        entity?.place = self.placeText.text!
        entity?.money = self.moneyText.text!
        entity?.style = self.typeLabel.text!
        entity?.name = self.nameText.text!
        entity?.image = UIImagePNGRepresentation(self.imageView.image!)! as NSData?
        try! context.save()
        
    }
    
    //MARK:- 取消鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameText.resignFirstResponder()
        self.placeText.resignFirstResponder()
        self.moneyText.resignFirstResponder()
    }
    
    //MARK:- 數字鍵盤及字型大小
    func showNumberPad()
    {
        self.nameText.font = UIFont(name: "Helvetica", size: 16.0)
        self.placeText.font = UIFont(name: "Helvetica", size: 16.0)
        self.moneyText.font = UIFont(name: "Helvetica", size: 16.0)
        self.moneyText.keyboardType = .numberPad
    
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

    //螢幕旋轉
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate : Bool {
        return true
    }

    //MARK: - showPickerView
    func showPickerView(_ sender:UITapGestureRecognizer)
    {
        let rect = CGRect(x: 0.0, y: 30.0, width: 270.0, height: 180.0)
        pickerView = UIPickerView(frame: rect)
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        pickerAlert = UIAlertController(title: "請選擇類型", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle:.alert)
        pickerAlert.view.addSubview(pickerView)
        
        let action1:UIAlertAction = UIAlertAction(title: "確定", style: .default) { (action) in
            
            
        }
         pickerAlert.addAction(action1)
        let action2:UIAlertAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
         pickerAlert.addAction(action2)
        
        self.present(pickerAlert, animated: true, completion: nil)
        
        
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
extension WarrantyViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.imageView.image = image
    }
    
}
extension WarrantyViewController:UIPickerViewDataSource,UIPickerViewDelegate
{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerArr[row]
        
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //暫存選到的項目
        
        self.pickerString = self.pickerArr[row]
        self.typeLabel.text = self.pickerString
        
        
        
    }
    
    
}





