//
//  ViewController.swift
//  TaipeiToilet
//
//  Created by 李佳駿 on 2017/3/15.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreData
import MapKit



class ViewController: UIViewController {
    
    
    var myMap:MKMapView!
    var locationManager:CLLocationManager!
    var logitude = 25.033493
    var latitude = 121.564101
    var didselectAnnotaion:MKAnnotation!
    

    var element = ""
    
    var titleFound = false
    var latFound = false
    var lonFound = false

    
    var titleString = ""
    var latString = ""
    var lonString = ""
    
    
    var titleArr:[String] = []
    var latArr:[String] = []
    var lonArr:[String] = []
    
    func createMap()
    {
        
        let width = UIScreen.main.bounds.width
        let hight = UIScreen.main.bounds.height
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: hight)
        //建立Map物件
        myMap = MKMapView(frame: rect)
        //加到view裡面
        self.view.addSubview(myMap)
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
        myMap.camera.altitude = 50
        //傾斜
        myMap.camera.pitch = 30
        //角度
        myMap.camera.heading = 45
        
    }
    func createLocationManager()
    {
        //建立定位管理物件
        locationManager = CLLocationManager()
        //設定精確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //設定活動模式
        locationManager.activityType = .fitness
        //設定代理器
        locationManager.delegate = self
        //開始更新資訊位置
        locationManager.startUpdatingLocation()
        
        let coordinate = CLLocationCoordinate2DMake(logitude , latitude )
        //建立橫向及縱向縮放大小產生縮放範圍
        let latDelta:CLLocationDegrees = 0.008
        let logDelta:CLLocationDegrees = 0.008
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, logDelta)
        //用座標及縮放範圍產生顯示範圍
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        //設定顯示範圍
        myMap.setRegion(region, animated: true)
    }
    //導航功能
    func btnAction(_ sender:AnyObject)
    {
        
        let corB:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: didselectAnnotaion!.coordinate.latitude, longitude: didselectAnnotaion!.coordinate.longitude)
        
        let markB:MKPlacemark = MKPlacemark(coordinate: corB, addressDictionary: nil)
        
        let itemB:MKMapItem = MKMapItem(placemark: markB)
        
        let option = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDefault]
        
        itemB.openInMaps(launchOptions: option)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //檢查是否有權限
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMap()
        createLocationManager()
        
        //取得路徑裡的資料
        let path = Bundle.main.path(forResource: "toilet", ofType: "xml")
        let xmlData = NSData(contentsOfFile:path!)
        let parser:XMLParser = XMLParser(data: xmlData as! Data)
        parser.delegate = self
        parser.parse()
        
        
        for item in 0...latArr.count - 1
        {
            
            let lat = (latArr[item] as NSString).doubleValue
            let lon = (lonArr[item] as NSString).doubleValue
            let title = titleArr[item]
            
            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let annotaion:MKPointAnnotation = MKPointAnnotation()
            annotaion.coordinate = coordinate
            annotaion.title = title
            
            
            self.myMap.addAnnotation(annotaion)
            
            
        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController:MKMapViewDelegate
{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //檢查是不是使用者定位
        if annotation is MKUserLocation
        {
            return nil
        }
        
        //取得重複使用的AnnotaionView
        let useId = "myPin"
        var pinView = myMap.dequeueReusableAnnotationView(withIdentifier: useId)
        
        if pinView == nil
        {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: useId)
        }else
        {
            pinView?.annotation = annotation
        }
        //使否顯示callout面板
        pinView?.canShowCallout = true
        //設定圖片
        pinView?.image = UIImage(named:"toilet.png")
        //建立一個按鈕
        let image:UIImage = UIImage(named: "gps.png")!
        let rect = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        let btn:UIButton = UIButton(type: .custom)
        btn.frame = rect
        btn.setImage(image, for: UIControlState())
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        //設定callout面板右側為按鈕
        pinView?.rightCalloutAccessoryView = btn
        
        
        
        return pinView
        
        
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //annotaionView被點擊的時候傳annotaion至didselectAnnotaion
        self.didselectAnnotaion = view.annotation
    }
    
    
}
extension ViewController:XMLParserDelegate
{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        element = elementName
        
        if element == "Title"
        {
            titleFound = true
        }
        if element == "Lng"
        {
            lonFound = true
        }
        if element == "Lat"
        {
            latFound = true
        }
        
        
        
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let newString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if newString.isEmpty
        {
            return
        }
        
        if titleFound
        {
            titleString = newString
            
        }
        if lonFound
        {
            lonString = newString
            
        }
        if latFound
        {
            latString = newString
            
        }
        
    }
    
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        element = elementName
        
        if element == "Title"
        {
            titleFound = false
            self.titleArr.append(titleString)
        }
        if element == "Lng"
        {
            lonFound = false
            self.lonArr.append(lonString)
        }
        if element == "Lat"
        {
            latFound = false
            self.latArr.append(latString)
        }

        
        
    }
    
    
    
}
extension ViewController:CLLocationManagerDelegate
{
    
}

