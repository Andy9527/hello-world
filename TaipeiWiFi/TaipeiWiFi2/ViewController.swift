//
//  ViewController.swift
//  TaipeiWiFi2
//
//  Created by 李佳駿 on 2017/3/15.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    var indicator:UIActivityIndicatorView!
    var task:URLSessionTask!
    var myMap:MKMapView!
    var locationManager:CLLocationManager!
    var logitude = 25.014099
    var latitude = 121.457703
    var didselectAnnotaion:MKAnnotation!
    
    var nameArr:[String] = []
    var latArr:[String] = []
    var lonArr:[String] = []
    var typeArr:[String] = []
    var areaArr:[String] = []
    
    var nameFound = false
    var areaFound = false
    var latFound = false
    var lonFound = false
    var typeFound = false
    
    var nameString = ""
    var areaString = ""
    var latString = ""
    var lonString = ""
    var typeString = ""
    
    var element = ""
    
    
    func createIndicatorView()
    {
        //建立指示器物件
        let width = UIScreen.main.bounds.width / 2.0
        let hight = UIScreen.main.bounds.height / 2.0
        indicator = UIActivityIndicatorView(activityIndicatorStyle:.whiteLarge)
        indicator.color = UIColor.gray
        indicator.center = CGPoint(x: width, y: hight)
        self.myMap.addSubview(indicator)
        indicator.startAnimating()
        
        
        
    }
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
        myMap.camera.altitude = 500
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
        createIndicatorView()
        
        let path = Bundle.main.path(forResource: "freeWifi", ofType: "xml")
        let xmlData = NSData(contentsOfFile:path!)
        let parser:XMLParser = XMLParser(data: xmlData as! Data)
        parser.delegate = self
        parser.parse()
        
        for item in 0...lonArr.count - 1
        {
            let lat = (latArr[item] as NSString).doubleValue
            let lon = (lonArr[item] as NSString).doubleValue
            let name = nameArr[item]
            let area = areaArr[item]
            let type = typeArr[item]
            
            
            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:lat , longitude: lon)
            let annotaion:MKPointAnnotation = MKPointAnnotation()
            annotaion.coordinate = coordinate
            annotaion.title = area + ":" + name
            annotaion.subtitle = type
            self.myMap.addAnnotation(annotaion)
            
        }
        
        self.indicator.stopAnimating()
        print("lon=\(lonArr)")
        print("lat=\(latArr)")
        print("type=\(typeArr)")
        print("name=\(nameArr)")
        print("area=\(areaArr)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }else
        {
            pinView?.annotation = annotation
        }
        pinView?.canShowCallout = true
        pinView?.image = UIImage(named: "wifi.png")
        let image:UIImage = UIImage(named: "gps.png")!
        let rect = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        let btn:UIButton = UIButton(type: .custom)
        btn.frame = rect
        btn.setImage(image, for: UIControlState())
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        pinView?.rightCalloutAccessoryView = btn
        
        
        
        return pinView
        
        
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        self.didselectAnnotaion = view.annotation
    }
    
    
}
extension ViewController:XMLParserDelegate
{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        element = elementName
            
        if element == "HOTSPOT_NAME"
        {
            nameFound = true
            
        }
        if element == "AREA"
        {
            
            areaFound = true
            
        }
        if element == "HOTSPOT_TYPE"
        {
            typeFound = true
        }
        if element == "LNG"
        {
            lonFound = true
        }
        if element == "LAT"
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
        
        if nameFound
        {
            nameString = newString
        }
        if typeFound
        {
            typeString = newString
        }
        if latFound
        {
            latString = newString
        }
        if lonFound
        {
            lonString = newString
        }
        if areaFound
        {
            areaString = newString
        }
        
    }
    
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if element == "HOTSPOT_NAME"
        {
            nameFound = false
            self.nameArr.append(nameString)
        }
        if element == "AREA"
        {
            
            areaFound = false
            self.areaArr.append(areaString)
            
        }
        if element == "HOTSPOT_TYPE"
        {
            typeFound = false
            self.typeArr.append(typeString)
        }
        if element == "LNG"
        {
            lonFound = false
            self.lonArr.append(lonString)
        }
        if element == "LAT"
        {
            latFound = false
            self.latArr.append(latString)
        }
        
        
        
    }
    
    
    
}
extension ViewController:CLLocationManagerDelegate
{
    
}





