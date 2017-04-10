//
//  SecondViewController.swift
//  surroundings
//
//  Created by 李佳駿 on 2016/10/3.
//  Copyright © 2016年 李佳駿. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var dataArray:[AnyObject] = []
    //指示器
    var ActivityIndicator:UIActivityIndicatorView!
    
    @IBOutlet var TableView: UITableView!
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       //建立指示器物件
       let width = UIScreen.main.bounds.width / 2.0
       let hight = UIScreen.main.bounds.height / 2.0
       //設定指示器樣式
       ActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
       //設定指示器位置
       ActivityIndicator.center = CGPoint(x: width, y: hight)
       //設定指示器顏色
       ActivityIndicator.color = UIColor.gray
       //將指示器加到畫面中
       self.view.addSubview(ActivityIndicator)
       //啟動指示器
       ActivityIndicator.startAnimating()
       
        //設定代理器
        TableView.dataSource = self
        TableView.delegate = self
        //建立URL物件
        let url:URL = URL(string: "http://opendata.epa.gov.tw/ws/Data/ATM00625/?$skip=0&$top=1000&format=json")!
        //建立URLSessionConfiguration物件
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        //建立URLSession物件
        let session:Foundation.URLSession = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        //建立task物件
        let task = session.downloadTask(with: url)
        //執行task
        task.resume()
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //用segue傳遞資料
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "second"
        {
            let cell = sender as! UITableViewCell
            let indexPath = TableView.indexPath(for: cell)
            
            let PM25 = dataArray[(indexPath?.row)!]["PM25"] as! String
            
            let PM25ViewController = segue.destination as! PM25ViewController
            
            if PM25.isEmpty
            {
                return
            
            }else
            {
                let pm25 = NSInteger(PM25)!
                
                switch pm25 {
                case 0...11:
                    PM25ViewController.text = "正常戶外活動。"
                    PM25ViewController.text2 = "正常戶外活動。"
                case 12...23:
                    PM25ViewController.text = "正常戶外活動。"
                    PM25ViewController.text2 = "正常戶外活動。"
                case 24...35:
                    PM25ViewController.text = "正常戶外活動。"
                    PM25ViewController.text2 = "正常戶外活動。"
                case 36...41:
                    PM25ViewController.text = "正常戶外活動。"
                    PM25ViewController.text2 = "有心臟、呼吸道及心血管疾病的成人與孩童感受到癥狀時，應考慮減少體力消耗，特別是減少戶外活動。"
                case 42...47:
                    PM25ViewController.text = "正常戶外活動。"
                    PM25ViewController.text2 = "有心臟、呼吸道及心血管疾病的成人與孩童感受到癥狀時，應考慮減少體力消耗，特別是減少戶外活動。"
                case 48...53:
                    PM25ViewController.text = "正常戶外活動。"
                    PM25ViewController.text2 = "有心臟、呼吸道及心血管疾病的成人與孩童感受到癥狀時，應考慮減少體力消耗，特別是減少戶外活動。"
                case 54...58:
                    PM25ViewController.text = "任何人如果有不適，如眼痛，咳嗽或喉嚨痛等，應該考慮減少戶外活動。"
                    PM25ViewController.text2 = "1.有心臟、呼吸道及心血管疾病的成人與孩童，應減少體力消耗，特別是減少戶外活動。2.老年人應減少體力消耗。3.具有氣喘的人可能需增加使用吸入劑的頻率。"

                case 59...64:
                    PM25ViewController.text = "任何人如果有不適，如眼痛，咳嗽或喉嚨痛等，應該考慮減少戶外活動。"
                    PM25ViewController.text2 = "1.有心臟、呼吸道及心血管疾病的成人與孩童，應減少體力消耗，特別是減少戶外活動。2.老年人應減少體力消耗。3.具有氣喘的人可能需增加使用吸入劑的頻率。"
                case 65...70:
                    PM25ViewController.text = "任何人如果有不適，如眼痛，咳嗽或喉嚨痛等，應該考慮減少戶外活動。"
                    PM25ViewController.text2 = "1.有心臟、呼吸道及心血管疾病的成人與孩童，應減少體力消耗，特別是減少戶外活動。2.老年人應減少體力消耗。3.具有氣喘的人可能需增加使用吸入劑的頻率。"

                case 71...100:
                    PM25ViewController.text = "任何人如果有不適，如眼痛，咳嗽或喉嚨痛等，應減少體力消耗，特別是減少戶外活動。"
                    PM25ViewController.text2 = "1.有心臟、呼吸道及心血管的成人與孩童，以及老年人應避免體力消耗，特別是避免戶外活動。2.具有氣喘的人可能需增加使用吸入劑的頻率。"
                default:
                    break
                }
                
                
                
                
            }
        

        }
        
    }


}
extension SecondViewController:UITableViewDataSource,UITableViewDelegate
{
    //群組數量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //儲存格數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataArray.count)
        return dataArray.count
    
    }
    //設定儲存格內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //取得cell
        let cell = TableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath)
        //PM2.5
        let PM25 = dataArray[(indexPath as NSIndexPath).row]["PM25"] as! String
        //測站
        let site = dataArray[(indexPath as NSIndexPath).row]["Site"] as! String
        //縣市
        let county = dataArray[(indexPath as NSIndexPath).row]["county"] as! String
        //時間
        let date = dataArray[(indexPath as NSIndexPath).row]["DataCreationDate"] as! String
        
        if PM25.isEmpty
        {
            //設定字型大小
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            //設定行數
            cell.textLabel?.numberOfLines = 10
            cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + "無" + "  " + "低"
            //背景顏色
            cell.backgroundColor = UIColor(red: 54.0, green: 246.0, blue: 149.0, alpha: 0.0)
            cell.detailTextLabel?.text = date

        }else
        {
            let pm25 = NSInteger(PM25)!
            
            switch pm25 {
                
            case 0...11:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "低"
                cell.backgroundColor = UIColor(red: 152/255.0, green: 226/255.0, blue: 127/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 12...23:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "低"
                cell.backgroundColor = UIColor(red: 104/255.0, green: 243/255.0, blue: 17/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 24...35:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "低"
                cell.backgroundColor = UIColor(red: 45/255.0, green: 104/255.0, blue: 7/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 36...41:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "中"
                cell.backgroundColor = UIColor(red: 255/255.0, green: 250/255.0, blue: 42/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 42...47:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "中"
                cell.backgroundColor = UIColor(red: 247/255.0, green: 193/255.0, blue: 93/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 48...53:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "中"
                cell.backgroundColor = UIColor(red: 241/255.0, green: 151/255.0, blue: 38/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 54...58:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "高"
                cell.backgroundColor = UIColor(red: 233/255.0, green: 96/255.0, blue: 92/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 59...64:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "高"
                cell.backgroundColor = UIColor(red: 230/255.0, green: 46/255.0, blue: 37/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 65...70:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "高"
                cell.backgroundColor = UIColor(red: 134/255.0, green: 42/255.0, blue: 39/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
            case 71...80:
                cell.textLabel?.font = UIFont(name: "Helvetica", size: 16.0)
                cell.textLabel?.numberOfLines = 10
                cell.textLabel?.text = county + " " + "測站:" + " " + site + " " + "PM2.5濃度:" + " " + PM25 + "  " + "非常高"
                cell.backgroundColor = UIColor(red: 225/255.0, green: 64/255.0, blue: 254/255.0, alpha: 1.0)
                cell.detailTextLabel?.text = date
                
            default:
                break
                
            }
            
        }
               
        
        
        return cell
    }
    //儲存格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
extension SecondViewController:URLSessionDelegate,URLSessionTaskDelegate,URLSessionDownloadDelegate
{
    //下載完成時
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //將下載後的資料轉成NSData格式
        let data:Data = try! Data(contentsOf: location)
        //將JSon資料轉成物件
        let dataDic = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        //將Any物件轉成AnyObject物件
        dataArray = dataDic as! [AnyObject]
        //重新整理
        TableView.reloadData()
        //指示器停止
        ActivityIndicator.stopAnimating()
               
        
    }
    
    
    
}




















