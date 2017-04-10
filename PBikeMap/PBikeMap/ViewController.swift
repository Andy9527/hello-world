//
//  ViewController.swift
//  PBikeMap
//
//  Created by 李佳駿 on 2017/2/15.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    //變數宣告
    var myMap:MKMapView!
    var locationManager:CLLocationManager!
   
    var an:MKAnnotation? = nil
    
    
    var nameArr:[String] = []
    var lonArr:[String] = []
    var latArr:[String] = []
    var nums1Arr:[String] = []
    var nums2Arr:[String] = []
    
    var task:URLSessionTask!
    
    var lat2:CLLocationDegrees = 22.662476
    var lon2:CLLocationDegrees = 120.482910
    
    
    //判定標籤字元
    var element:String = ""
    
    var name:String = ""
    var lon:String = ""
    var lat:String = ""
    var nums1:String = ""
    var nums2:String = ""
    
    var nameFound = false
    var lonFound = false
    var latFound = false
    var nums1Found = false
    var nums2Found = false
    
    override func viewDidAppear(_ animated: Bool) {
        //檢查是否有權限
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //建立定位管理物件
        locationManager = CLLocationManager()
        //設定精確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //設定活動模式
        locationManager.activityType = .fitness
        //設定代理器
        locationManager.delegate = self
        //開始更新資訊位置
        locationManager.stopUpdatingLocation()
        
        
        
        let cor:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat2, longitude: lon2)
        //建立橫向及縱向縮放大小產生縮放範圍
        let latDelta:CLLocationDegrees = 0.008
        let logDelta:CLLocationDegrees = 0.008
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, logDelta)
        //用座標及縮放範圍產生顯示範圍
        let region:MKCoordinateRegion = MKCoordinateRegionMake(cor, span)
        
        let width = UIScreen.main.bounds.width
        let hight = UIScreen.main.bounds.height
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: hight)
        
        //建立地圖物件
        myMap = MKMapView(frame: rect)

        
        //建立URL物件
        let url:URL = URL(string: "http://pbike.pthg.gov.tw/xml/stationlist.aspx")!
        //建立URLSessionConfiguration物件
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        //建立Session物件
        let session:URLSession = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        //dowloadURL
        task = session.downloadTask(with: url)
        task.resume()
        
     
        
        //設定代理器
         myMap.delegate = self
        //比例尺
         myMap.showsScale = true
        //指南針
         myMap.showsCompass = true
        //交通
         myMap.showsTraffic = true
        //樣式
         myMap.mapType = .standard
        //地面高度
         myMap.camera.altitude = 1400
        //傾斜
         myMap.camera.pitch = 30
        //角度
         myMap.camera.heading = 45
        //設定UserTrackingMode
         myMap.userTrackingMode = .followWithHeading
        //設定顯示範圍
        myMap.setRegion(region, animated: true)
        //加到View裡
        self.view.addSubview(myMap)
        
        
    }
    //導航功能
    func btnAction(_ sender:AnyObject)
    {
        
        
        let corB:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: an!.coordinate.latitude, longitude: an!.coordinate.longitude)
        
        let markB:MKPlacemark = MKPlacemark(coordinate: corB, addressDictionary: nil)
        
        let itemB:MKMapItem = MKMapItem(placemark: markB)
        
        let option = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDefault]
        
        itemB.openInMaps(launchOptions: option)

        
        
    }

    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:URLSessionDelegate,URLSessionDownloadDelegate,URLSessionTaskDelegate
{
    //下載後
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
       
        //將URL轉成Data
        let data:NSData = try! NSData(contentsOf: location)
        //建立XMLParser物件
        let parser:XMLParser = XMLParser(data: data as Data)
        //設定代理氣
        parser.delegate = self
        //開始剖析
        parser.parse()
        
        
        print("lonArr=\(lonArr),latArr=\(latArr),nameArr=\(nameArr),nums1Arr=\(nums1Arr),nums2Arr=\(nums2Arr)")
        
        //用for迴圈撈出資料給大頭針物件,再將大頭針物件插在地圖上
        for item in 0...lonArr.count - 1
        {
            
            let lon3 = (lonArr[item] as NSString).doubleValue
            let lat3 = (latArr[item] as NSString).doubleValue
            let title = nameArr[item] as String
            let nums1 = nums1Arr[item] as String
            let nums2 = nums2Arr[item] as String
            let cor3:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lon3, longitude: lat3)
            
            
            
            let annotation:MKPointAnnotation = MKPointAnnotation()
     
            annotation.coordinate = cor3
            annotation.title = title
            annotation.subtitle = "目前數量:" + nums1 + " " + "尚餘空位:" + nums2
        
            self.myMap.addAnnotation(annotation)
        }
        
       
    }
    
}
extension ViewController:XMLParserDelegate
{
    //開始標籤
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        element = elementName
        
        if  element == "StationName"
        {
            nameFound = true
        }
        
        if  element == "StationLon"
        {
            lonFound = true
            
        }
        if  element == "StationLat"
        {
            latFound = true
            
        }
        if  element == "StationNums1"
        {
            nums1Found = true
        }
        if  element == "StationNums2"
        {
            nums2Found = true
        }
        
        
    }
    
    
    
    //取出內容
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let newString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        //檢查是否為空值
        if newString.isEmpty
        {
            return
        }
        
        //將取出的內容存放到變數裡
        if nameFound
        {
            name = newString
            
        }
        if lonFound
        {
            lon = newString
            
        }

        if latFound
        {
            lat = newString
            
        }

        if nums1Found
        {
            nums1 = newString
            
        }

        if nums2Found
        {
            nums2 = newString
            
            
        }
       
        
        
    
    }
    
    
    
    
    
    //結束標籤
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    
        element = elementName
        
        if element == "StationName"
        {
            nameFound = false
            self.nameArr.append(name)
        }
        
        if element == "StationLon"
        {
            lonFound = false
            self.lonArr.append(lon)
            
        }
        if element == "StationLat"
        {
            latFound = false
            self.latArr.append(lat)
        }
        if element == "StationNums1"
        {
            nums1Found = false
            self.nums1Arr.append(nums1)
        }
        if element == "StationNums2"
        {
            nums2Found = false
            self.nums2Arr.append(nums2)
        }

    }
    
    
    
    
    
    
}

extension ViewController:MKMapViewDelegate
{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        
        
        if annotation is MKUserLocation
        {
            return nil
        }
        
        
        let useId = "myPin"
        var pinView = myMap.dequeueReusableAnnotationView(withIdentifier: useId)
        
        if pinView == nil
        {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: useId)
            pinView?.canShowCallout = true
            pinView?.image = UIImage(named: "Bike.png")
            
            let image:UIImage = UIImage(named: "gps.png")!
            let rect = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
            let btn:UIButton = UIButton(type: .custom)
            btn.frame = rect
            btn.setImage(image, for: UIControlState())
            btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            pinView?.rightCalloutAccessoryView = btn
        }else
        {
            pinView?.annotation = annotation
        }
        
        
        
        
        return pinView
        
       
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.task.resume()
        self.an = view.annotation
        
        
        
    }
    
   
    
    
    
}

extension ViewController:CLLocationManagerDelegate
{
    
}












