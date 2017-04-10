//
//  SecondViewController.swift
//  CarCare
//
//  Created by 李佳駿 on 2017/3/31.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityName:String = "Warranty"
    var request:NSFetchRequest<Warranty>!
    var fetchController:NSFetchedResultsController<Warranty>!
    var sort:NSSortDescriptor!
    
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        request = NSFetchRequest(entityName: entityName)
        sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "date", cacheName: nil)
        fetchController.delegate = self
        try! fetchController.performFetch()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationItem.title = "保修紀錄"
        
        
    }
    //螢幕旋轉
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
        
        
    }
    //利用segue傳遞資訊
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //先判斷segue
        if segue.identifier == "edit"
        {
            //判斷被點擊到的index
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let fetchObject = fetchController.object(at: indexPath)
                let WarrantyVC = segue.destination as! WarrantyViewController
                WarrantyVC.entity = fetchObject
                
                
            }
            
            
        }
        
        
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
extension SecondViewController:UITableViewDataSource,UITableViewDelegate
{
    //群組數量
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = fetchController.sections?.count
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
        
        let object = fetchController.object(at: indexPath)
        
        let date = object.date!
        let money = object.money!
        let place = object.place!
        let name = object.name!
        let style = object.style!
        let image = UIImage(data: object.image as! Data)
        
        cell.backgroundColor = UIColor(red: 242.0/255, green: 131.0/255, blue: 107.0/255, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        cell.textLabel?.numberOfLines = 5
        cell.textLabel?.text = "花費項目:" + name + " " + "費用類型:" + style
        + "\n" + "花費地點:" + place + " " + "費用金額:" + money
        cell.imageView?.image = image
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 14.0)
        cell.detailTextLabel?.text = date
        
        
        return cell
        
    }
    //cell的hight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
}
extension SecondViewController:NSFetchedResultsControllerDelegate
{
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
    
    
    
}
