//
//  IncomeViewController.swift
//  Money
//
//  Created by 李佳駿 on 2017/3/22.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class IncomeViewController: UIViewController {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityName:String = "Income"
    var entity:Income? = nil
    var entityDis:NSEntityDescription!
    
    var dateGesture:UITapGestureRecognizer!
    var styleGesture:UITapGestureRecognizer!
    var dateAlert:UIAlertController!
    var datePicker:UIDatePicker!
    var pickerView:UIPickerView!
    var pickerArr:[String] = []
    var pickerString:String = ""
    
    
    
    
    @IBOutlet var name: UITextField!
    @IBOutlet var money: UITextField!
    @IBOutlet var date: UILabel!
    @IBOutlet var style: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    @IBAction func album(_ sender: Any)
    {
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
    @IBAction func camera(_ sender: Any)
    {
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
    //返回上一頁
    func dismiss()
    {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //新增
    func createNewTable()
    {
       entityDis = NSEntityDescription.entity(forEntityName: entityName, in: context)
       entity = Income(entity: entityDis, insertInto: context)
       entity?.name = name.text
       entity?.style = style.text
       entity?.money = money.text
       entity?.date = date.text
       entity?.image = UIImagePNGRepresentation(imageView.image!)! as NSData?
       try! context.save()
        
    }
    //編輯
    func editTable()
    {
        
        entity?.name = name.text
        entity?.style = style.text
        entity?.date = date.text
        entity?.money = money.text
        entity?.image = UIImagePNGRepresentation(imageView.image!)! as NSData?
        
        try! context.save()
        
        
        
    }
    //date to Stirng
    func showDateString(date:Date) -> String
    {
        let dateFMT:DateFormatter = DateFormatter()
        dateFMT.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStrig = dateFMT.string(from: date)
        
        return dateStrig
        
    }
    //DatePicker物件
    func showDatePicker(_ sender:UITapGestureRecognizer)
    {
        
        
        
        
        let rect = CGRect(x: 0.0, y: 40.0, width: 390.0, height: 180.0)
        datePicker = UIDatePicker(frame: rect)
        datePicker.datePickerMode = .dateAndTime
        
        dateAlert = UIAlertController(title: "請選擇時間", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        dateAlert.view.addSubview(datePicker)
        
        let action1:UIAlertAction = UIAlertAction(title: "確定", style: .default) { (action) in
            self.date.text = self.showDateString(date:self.datePicker.date)
        }
        dateAlert.addAction(action1)
        let action2:UIAlertAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        dateAlert.addAction(action2)
        
        self.present(dateAlert, animated: true, completion: nil)
        
        
        
    }
    //UIPicker物件
    func showPickerView(_ sender:UITapGestureRecognizer)
    {
        
        let rect = CGRect(x: 0.0, y: 30.0, width: 390.0, height: 180.0)
        pickerView = UIPickerView(frame: rect)
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        dateAlert = UIAlertController(title: "請選擇項目類型", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        dateAlert.view.addSubview(pickerView)
        
        let action1:UIAlertAction = UIAlertAction(title: "確定", style: .default) { (action) in
            
            
            
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
    
    //取消鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.name.resignFirstResponder()
        self.money.resignFirstResponder()
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
        if name.text == ""
        {
            animationView("請輸入項目")
            return
        }
        if money.text == ""
        {
            animationView("請輸入金額")
            return
        }
        
        if entity != nil
        {
            editTable()
        }else
        {
            createNewTable()
        }
        dismiss()
        
        }
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerArr.append("薪水")
        pickerArr.append("獎金")
        pickerArr.append("專案收入")
        pickerArr.append("兼職收入")
        pickerArr.append("租賃收入")
        pickerArr.append("營業收入")
        pickerArr.append("利息收入")
        pickerArr.append("廣告代言")
        pickerArr.append("退休金")
        pickerArr.append("補助金")
        pickerArr.append("其他收入")
        
        
        let image = UIImage(named: "sale.png")
        let button:UIButton = UIButton.init(type: .custom)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        button.addTarget(self, action: #selector(save), for: UIControlEvents.touchUpInside)
        let barbutton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barbutton
        
        
        dateGesture = UITapGestureRecognizer(target: self, action: #selector(showDatePicker(_:)))
        dateGesture.numberOfTapsRequired = 1
        date.addGestureRecognizer(dateGesture)
        date.isUserInteractionEnabled = true
        styleGesture = UITapGestureRecognizer(target: self, action: #selector(showPickerView(_:)))
        styleGesture.numberOfTapsRequired = 1
        style.addGestureRecognizer(styleGesture)
        style.isUserInteractionEnabled = true
        
        self.style.text = self.pickerArr[0]
        self.date.text = showDateString(date: Date())
        self.money.keyboardType = UIKeyboardType.numberPad
        self.imageView.image = UIImage(named: "QBoy.png")
        
        if entity != nil
        {
            date.text = entity?.date
            money.text = entity?.money
            name.text = entity?.name
            style.text = entity?.style
            imageView.image = UIImage(data:(entity?.image)! as Data)
            
            try! context.save()
            
        }
        
        
        
        if entity != nil
        {
            self.navigationItem.title = "收入編輯"
        }else
        {
            self.navigationItem.title = "收入新增"
        }
        

        
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
extension IncomeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.imageView.image = image
    }
    
    
}
extension IncomeViewController:UIPickerViewDataSource,UIPickerViewDelegate
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
        self.style.text = self.pickerString
        
        
        
    }
    
    
}
