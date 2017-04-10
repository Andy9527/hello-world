//
//  FirstViewController.swift
//  Money
//
//  Created by 李佳駿 on 2017/3/22.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entityName:String = "Expenditure"
    var fetchRequest:NSFetchRequest<Expenditure>!
    var fetchController:NSFetchedResultsController<Expenditure>!
    var fetchSort:NSSortDescriptor!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        fetchRequest = NSFetchRequest(entityName: entityName)
        fetchSort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [fetchSort]
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "date", cacheName: nil)
        fetchController.delegate = self
        try! fetchController.performFetch()
        
        
    }

    //利用segue傳遞資訊
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //先判斷segue
        if segue.identifier == "first"
        {
            //判斷被點擊到的index
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let object = fetchController.object(at: indexPath)
                
                let expenditure = segue.destination as! ExpenditureViewController
                expenditure.entity = object
                
                
                
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
        
        let date = object.date
        let name = object.name
        let style = object.style
        let place = object.place
        let money = object.money
        let image = UIImage(data: object.image as! Data)
        
        cell.backgroundColor = UIColor(red: 255.0/255, green: 97.0/255, blue: 56.0/255, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.text = "項目:" + name! + "\n" + "類型:" + style! + "\n" + "金額:" + money! + "\n" + "地點:" + place! + "\n" + "時間:" + date!
        cell.imageView?.image = image
        
        
        return cell
        
    }
    //cell的hight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let managedObject:NSManagedObject = self.fetchController.object(at: indexPath) as NSManagedObject
        context.delete(managedObject)
        try! context.save()
        
        
    }
    
}
extension FirstViewController:NSFetchedResultsControllerDelegate
{
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
    
}







