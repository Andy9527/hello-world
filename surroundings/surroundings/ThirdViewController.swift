//
//  ThirdViewController.swift
//  surroundings
//
//  Created by 李佳駿 on 2016/10/3.
//  Copyright © 2016年 李佳駿. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var dataArray:[AnyObject] = []
    var ActivityIndicator:UIActivityIndicatorView!

    @IBOutlet var TableView: UITableView!
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = UIScreen.main.bounds.width / 2.0
        let hight = UIScreen.main.bounds.height / 2.0
        ActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ActivityIndicator.center = CGPoint(x: width, y: hight)
        ActivityIndicator.color = UIColor.gray
        self.view.addSubview(ActivityIndicator)
        ActivityIndicator.startAnimating()
        
        
        TableView.dataSource = self
        TableView.delegate = self
        
        let url:URL = URL(string: "http://opendata.epa.gov.tw/ws/Data/UVIF/?$orderby=Name&$skip=0&$top=1000&format=json")!
        let confuguration:URLSessionConfiguration = URLSessionConfiguration.default
        let session:Foundation.URLSession = Foundation.URLSession(configuration: confuguration, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.downloadTask(with: url)
        task.resume()
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ThirdViewController:UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "ThirdCell", for: indexPath)
        
        
        let UVI = dataArray[(indexPath as NSIndexPath).row]["UVI"] as! String
        let name = dataArray[(indexPath as NSIndexPath).row]["Name"] as! String
        let type = dataArray[(indexPath as NSIndexPath).row]["Type"] as! String
        let UVIStatus = dataArray[(indexPath as NSIndexPath).row]["UVIStatus"] as! String
        let PublishTime = dataArray[(indexPath as NSIndexPath).row]["PublishTime"] as! String
        
        switch UVIStatus {
        case "低量級":
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 4
            cell.textLabel?.text = name + " " + "預報型態" + type + " " + "UVI:" + UVI + UVIStatus
            cell.backgroundColor = UIColor.green
            cell.detailTextLabel?.text = PublishTime
        case "中量級":
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 4
            cell.textLabel?.text = name + " " + "預報型態:" + type + " " + "UVI:" + UVI + " " + UVIStatus
            cell.backgroundColor = UIColor.yellow
            cell.detailTextLabel?.text = PublishTime

        case "高量級":
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 4
            cell.textLabel?.text = name + " " + "預報型態:" + type + " " + "UVI:" + UVI + " " + UVIStatus + "\n" + "曬傷時間:30分鐘內" + " " + "帽子/陽傘+防曬液+太陽眼鏡+儘量待在陰涼處。"
            cell.backgroundColor = UIColor.orange
            cell.detailTextLabel?.text = PublishTime

        case "過量級":
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 4
            cell.textLabel?.text = name + " " + "預報型態:" + type + " " + "UVI:" + UVI + " " + UVIStatus + "\n" + "曬傷時間:20分鐘內" + " " + "帽子/陽傘+防曬液+太陽眼鏡+陰涼處+長袖衣物+10至14時最好不在烈日下活動。"
            cell.backgroundColor = UIColor.red
            cell.detailTextLabel?.text = PublishTime

        case "危險級":
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            cell.textLabel?.numberOfLines = 4
            cell.textLabel?.text = name + " " + "預報型態:" + type + " " + "UVI:" + UVI + " " + UVIStatus + "\n" + "曬傷時間:15分鐘內" + " " + "帽子/陽傘+防曬液+太陽眼鏡+陰涼處+長袖衣物+10至14時最好不在烈日下活動。"
            cell.backgroundColor = UIColor.purple
            cell.detailTextLabel?.text = PublishTime


        default:
            break
        }

        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
}
extension ThirdViewController:URLSessionDelegate,URLSessionTaskDelegate,URLSessionDownloadDelegate
{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data:Data = try! Data(contentsOf: location)
        let dataDic = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        dataArray = dataDic as! [AnyObject]
        TableView.reloadData()
        ActivityIndicator.stopAnimating()
    }
    
    
    
    
}
















