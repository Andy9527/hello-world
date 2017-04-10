//
//  ExpenditureViewController.swift
//  Money
//
//  Created by 李佳駿 on 2017/3/22.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class ExpenditureViewController: UIViewController {

    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityName:String = "Expenditure"
    var entity:Expenditure? = nil
    var entityDis:NSEntityDescription!
    
    var dateGesture:UITapGestureRecognizer!
    var styleGesture:UITapGestureRecognizer!
    var dateAlert:UIAlertController!
    var datePicker:UIDatePicker!
    var pickerView:UIPickerView!
    var pickerArr:[String] = []
    var pickerString:String = ""
    
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var money: UITextField!
    @IBOutlet var place: UITextField!
    @IBOutlet var style: UILabel!
    @IBOutlet var name: UITextField!
    @IBAction func camera(_ sender: Any) {
        //相機物件
        //建立UIImagePickerController物件
        let pickerController = UIImagePickerController()
        //設定代理器
        pickerController.delegate = self
        //設定樣式
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //允許編輯
        pickerController.allowsEditing = true
        //推送畫面
        self.present(pickerController, animated: true, completion: nil)
        
    }
    @IBAction func album(_ sender: Any) {
        //相簿物件
        //建立UIImagePickerController物件
        let pickerController = UIImagePickerController()
        //設定代理器
        pickerController.delegate = self
        //設定樣式
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //允許編輯
        pickerController.allowsEditing = true
        //推送畫面
        self.present(pickerController, animated: true, completion: nil)
        
        
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

    //返回上一頁
    func dismiss()
    {
        _ = navigationController?.popViewController(animated: true)
    }

    //新增
    func createNewTable()
    {
        entityDis = NSEntityDescription.entity(forEntityName: entityName, in: context)
        entity = Expenditure(entity: entityDis, insertInto: context)
        entity?.name = name.text
        entity?.style = style.text
        entity?.place = place.text
        entity?.date = date.text
        entity?.money = money.text
        entity?.image = UIImagePNGRepresentation(imageView.image!)! as NSData?
        
        try! context.save()
        
        
        
    }
    //編輯
    func editTable()
    {
        
        entity?.name = name.text
        entity?.style = style.text
        entity?.place = place.text
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
        self.place.resignFirstResponder()
    }

    //儲存
    func save()
    {
        
        
        //增加防呆
        if name.text == ""
        {
            animationView("請輸入項目")
            return
        }
        if place.text == ""
        {
            animationView("請輸入地點")
            return
        }
        if money.text == ""
        {
            animationView("請輸入金額")
            return
            
        }
        
        //是否有資料表 有則編輯 無則新增
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

        
        pickerArr.append("居家生活")
        pickerArr.append("休閒娛樂")
        pickerArr.append("餐飲食品")
        pickerArr.append("網路購物")
        pickerArr.append("網路電信")
        pickerArr.append("交通通勤")
        pickerArr.append("維修保養")
        pickerArr.append("服飾美容")
        pickerArr.append("租金")
        pickerArr.append("稅金")
        pickerArr.append("保險")
        pickerArr.append("罰緩")
        pickerArr.append("投資")
        pickerArr.append("利息貸款")
        pickerArr.append("進修學習")
        pickerArr.append("書籍雜誌")
        pickerArr.append("借出")
        pickerArr.append("其他支出")
        //MARK:- BarButtonItem
        
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
            place.text = entity?.place
            name.text = entity?.name
            style.text = entity?.style
            imageView.image = UIImage(data:(entity?.image)! as Data)
            
            try! context.save()
            
        }

        
        
        if entity != nil
        {
            self.navigationItem.title = "支出編輯"
        }else
        {
            self.navigationItem.title = "支出新增"
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
extension ExpenditureViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        let image = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.imageView.image = image
    }
    
    
}
extension ExpenditureViewController:UIPickerViewDataSource,UIPickerViewDelegate
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
