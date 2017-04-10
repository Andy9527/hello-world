//
//  SecondViewController.swift
//  PetRecord
//
//  Created by 李佳駿 on 2017/3/7.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityName:String = "Spend"
    var request:NSFetchRequest<Spend>!
    var fetchController:NSFetchedResultsController<Spend>!
    var sort:NSSortDescriptor!
    
    
    
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
        self.tableView.rowHeight = 100
        
        self.navigationItem.title = "寵物花費紀錄"
        
        
    }
    //利用segue傳遞資訊
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //先判斷segue
        if segue.identifier == "pet"
        {
            //判斷被點擊到的index
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let object = fetchController.object(at: indexPath)
                
                let petSpend = segue.destination as! PetSpendViewController
                petSpend.entity = object
                
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
        
        
        let obeject = fetchController.object(at: indexPath)
        let name = obeject.name
        let money = obeject.money
        let place = obeject.place
        let image = UIImage(data: obeject.image as! Data)
        let date = obeject.date
        cell.backgroundColor = UIColor(red: 255.0/255, green: 211.0/255, blue: 147.0/255, alpha: 1.0)
        cell.imageView?.image = image
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.text = "項目:" + name! + "\n" + "地點:" + place! + "\n" + "金額:" + money! + "\n" + "時間:" + date!
       
        
        
        
        return cell
        
    }
    //刪除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let managerObject:NSManagedObject = fetchController.object(at: indexPath) as NSManagedObject
        context.delete(managerObject)
        try! context.save()
        
    }
}
extension SecondViewController:NSFetchedResultsControllerDelegate
{
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
    
    
    
}
