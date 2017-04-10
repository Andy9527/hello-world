//
//  FirstViewController.swift
//  PetRecord
//
//  Created by 李佳駿 on 2017/3/7.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    var entityName = "Health"
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var request:NSFetchRequest<Health>!
    var fetchController:NSFetchedResultsController<Health>!
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
        self.tableView.rowHeight = 120
        
        
        
        
    }

    //利用segue傳遞資訊
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //先判斷segue
        if segue.identifier == "pet"
        {
            //判斷被點擊到的index
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                //取得被點擊的內容
                let object = fetchController.object(at: indexPath)
                //將被點擊的內容傳遞到BusController
                let PetRecord = segue.destination as! PetRecordViewController
                PetRecord.entity = object
                
                
            }
            
            
        }
        
        
        
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
extension FirstViewController:UITableViewDataSource,UITableViewDelegate
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
        
        let name = object.name
        let money = object.money
        let place = object.place
        let date = object.date
        let medical = object.medical
        let image = UIImage(data: object.image as! Data)
        cell.backgroundColor = UIColor(red: 255.0/255.0, green: 211.0/255.0, blue: 147.0/255.0, alpha: 1.0)
        cell.imageView?.image = image
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.text = "寵物名稱:" + name! + "\n" + "保健項目:" + medical! + "\n" + "保健金額:" + money! + "\n" + "保健地點:" + place! +
        "\n" + "保健時間:" + date!
        
        
    
        return cell
        
    }
    //刪除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let managerObject:NSManagedObject = fetchController.object(at: indexPath) as NSManagedObject
        context.delete(managerObject)
        try! context.save()
        
    }
    
}
extension FirstViewController:NSFetchedResultsControllerDelegate
{
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
    
    
}



