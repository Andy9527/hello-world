//
//  FirstViewController.swift
//  CarCare
//
//  Created by 李佳駿 on 2017/3/31.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    //MARK:- 屬性宣告
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityName:String = "Record"
    var fetchRequest:NSFetchRequest<Record>!
    var request:NSFetchRequest<Record>!
    var fetchController:NSFetchedResultsController<Record>!
    var sort:NSSortDescriptor!
    var sort2:NSSortDescriptor!
    
    
    var milageTap:UITapGestureRecognizer!
    var dateAlert:UIAlertController!
    var milageText:UITextField!
    var rightButton:UIBarButtonItem!
    //MARK:- 物件連結
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rect = CGRect(x: 5.0, y: 80.0, width:260.0, height: 30.0)
        milageText = UITextField(frame: rect)
        milageText.font = UIFont(name: "Helvetica", size: 16.0)
        milageText.keyboardType = .numberPad
        
        milageTap = UITapGestureRecognizer(target: self, action: #selector(showDateText))
        milageTap.numberOfTapsRequired = 1
        titleLabel.addGestureRecognizer(milageTap)
        titleLabel.isUserInteractionEnabled = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        fetchRequest = NSFetchRequest(entityName: entityName)
        sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchController = NSFetchedResultsController(fetchRequest:fetchRequest, managedObjectContext: context, sectionNameKeyPath: "date", cacheName: nil)
        fetchController.delegate = self
        try! fetchController.performFetch()

        
        request = NSFetchRequest(entityName: entityName)
        sort = NSSortDescriptor(key: "milage", ascending: false)
        let fetch = try! context.fetch(request)
        for record2 in fetch
        {
            
            self.milageText.text = record2.milage!
            self.titleLabel.text = "上次加油時的總里程數:" + self.milageText.text! + "(km)"
            print("milageText=\(milageText.text!)")
            

            
        }
        
        self.navigationItem.title = "加油紀錄"
    }
        //顯示Alert
    func showDateText()
    {
        
        dateAlert = UIAlertController(title: "請輸入目前總里程數", message: "\n\n\n\n\n\n", preferredStyle:.alert)
        dateAlert.view.addSubview(milageText)
        
        let action1:UIAlertAction = UIAlertAction(title: "確定", style: .default) { (action) in
            
            if self.milageText.text == ""
            {
                self.animationView("請輸入目前總公里數")
            }else{
            self.titleLabel.text = "目前總公里數:" + self.milageText.text! + "(km)"
            
            }
        }
        dateAlert.addAction(action1)
        let action2:UIAlertAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        dateAlert.addAction(action2)
        
        self.present(dateAlert, animated: true, completion: nil)
        
        
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
    //MARK:- 刪除儲存格
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let managerObject = fetchController.object(at: indexPath) as NSManagedObject
            context.delete(managerObject)
            try! context.save()
            
        }
    }
    //螢幕旋轉
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate : Bool {
        return true
    }

    
    //利用segue傳遞資訊
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //先判斷segue
        
      
       if self.milageText.text == ""
       {
        self.showDateText()
        return
       }else
       {
        
        if segue.identifier == "add"
        {
            
            let recordVC = segue.destination as! RcordViewController
            recordVC.milageString = self.milageText.text!
            
            
        }
        
       }
        
       if segue.identifier == "edit"
       {
        
          if let indexPath = self.tableView.indexPathForSelectedRow
          {
          let fetchObject = fetchController.object(at: indexPath)
          let recordVC = segue.destination as! RcordViewController
          recordVC.entity = fetchObject
         }
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
extension FirstViewController:UITableViewDataSource,UITableViewDelegate
{
    //群組數量
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = self.fetchController.sections?.count
        return count!
    }
    
    //儲存格數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = fetchController.sections?[section].numberOfObjects
        return row!
    }
    
    //設定Cell內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let fetchObject = fetchController.object(at: indexPath)
        
        let date = fetchObject.date
        let liter = fetchObject.liter
        let milage = fetchObject.milage
        let oilPrice = fetchObject.price
        let money = fetchObject.money
        let consumption = fetchObject.consumption
        
        
        
        cell.backgroundColor = UIColor(red: 242.0/255, green: 131.0/255, blue: 107.0/255, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        cell.textLabel?.numberOfLines = 5
        cell.textLabel?.text = "里程數:" + milage! + "(km)" + " " + "油耗:" + consumption! + "(L/100km)" + "\n" + "公升數:" + liter! + "(L)" + " " + "油價:" + oilPrice! + "(元/L)" + " " + "油錢:" + money! + "(元)"
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 14.0)
        cell.detailTextLabel?.text = date!
        
        
        
        
        return cell
        
    }
    //cell的hight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
extension FirstViewController:NSFetchedResultsControllerDelegate
{
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
    
    
}




