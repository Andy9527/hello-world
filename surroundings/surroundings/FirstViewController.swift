//
//  FirstViewController.swift
//  surroundings
//
//  Created by 李佳駿 on 2016/10/3.
//  Copyright © 2016年 李佳駿. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var dataArray:[AnyObject] = []
    
    var ActivityIndicator:UIActivityIndicatorView!

    @IBOutlet var TableView: UITableView!
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let width = UIScreen.main.bounds.width / 2.0
        let hight = UIScreen.main.bounds.height / 2.0
        ActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ActivityIndicator.center = CGPoint(x: width, y: hight)
        ActivityIndicator.color = UIColor.gray
        //ActivityIndicator.backgroundColor = UIColor.grayColor()
        
        self.view.addSubview(ActivityIndicator)
        ActivityIndicator.startAnimating()
    
        TableView.dataSource = self
        TableView.delegate = self
        //建立URL
        let url:URL = URL(string: "http://opendata.epa.gov.tw/ws/Data/REWXQA/?$orderby=SiteName&$skip=0&$top=1000&format=json")!
        let Configuration:URLSessionConfiguration = URLSessionConfiguration.default
        let session:Foundation.URLSession = Foundation.URLSession(configuration: Configuration, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.downloadTask(with: url)
        task.resume()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension FirstViewController:URLSessionDelegate,URLSessionDownloadDelegate,URLSessionTaskDelegate
{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data:Data = try! Data(contentsOf: location)
        let  dataDict = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        dataArray = dataDict as! [AnyObject]
        TableView.reloadData()
        ActivityIndicator.stopAnimating()
        
    }
    
    
}
extension FirstViewController:UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath)
        let PSI = dataArray[(indexPath as NSIndexPath).row]["PSI"] as! String
        let psi = NSInteger(PSI)!
        let SiteName = dataArray[(indexPath as NSIndexPath).row]["SiteName"] as! String
        let Status = dataArray[(indexPath as NSIndexPath).row]["Status"] as? String
        let County = dataArray[(indexPath as NSIndexPath).row]["County"] as? String
        let PublishTime = dataArray[(indexPath as NSIndexPath).row]["PublishTime"] as? String
        
        
        switch psi {
        case 0...50:
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 5
            cell.textLabel!.text = County! + " " + "測站:" + " " + SiteName + " " + "空氣品質污染指標(PSI):" + " " + PSI + " " + Status! + "\n" + "對一般民眾身體健康無影響。"
            cell.detailTextLabel!.text = PublishTime
            cell.backgroundColor = UIColor.green
        case 51...100:
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 5
            cell.textLabel!.text = County! + " " + "測站:" + " " + SiteName +  " " + "空氣品質即時指標(PSI):" + " " + PSI + " " + Status! + "\n" + "對敏感族群健康無立即影響。"
            cell.detailTextLabel!.text = PublishTime
            cell.backgroundColor = UIColor.yellow
        case 101...199:
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 5
            cell.textLabel!.text = County! + " "  + "測站:" + " " + SiteName +  " " + "空氣品質即時指標(PSI):" + " " + PSI + " " + Status! + "\n" + "對敏感族群會有輕微症狀惡化的現象。"
            cell.detailTextLabel!.text = PublishTime
            cell.backgroundColor = UIColor.red
        case 200...299:
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 5
            cell.textLabel!.text = County! + " "  + "測站:" + " " + SiteName +  " " + "空氣品質即時指標(PSI):" + " " + PSI + " " + Status! + "\n" + "對敏感族群會有明顯惡化的現象，降低其運動能力；一般大眾則視身體狀況，可能產生各種不同的症狀。"
            cell.detailTextLabel!.text = PublishTime
            cell.backgroundColor = UIColor.purple
        case 300...500:
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 5
            cell.textLabel!.text = County! + " "  + "測站:" + " " + SiteName +  " " + "空氣品質即時指標(PSI):" + " " + PSI + " " + Status! + "\n" + "患有心臟或呼吸系統疾病的人的病徵會明顯轉壞，而一般人士普遍也會感到不適，包括眼睛不適、氣喘、咳嗽、痰多、喉痛等等。"
            cell.detailTextLabel!.text = PublishTime
            cell.backgroundColor = UIColor.brown
        default:
            break
        }
        
        

        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
    
    
    
}
















