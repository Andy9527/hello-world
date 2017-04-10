//
//  ThirdViewController.swift
//  CarCare
//
//  Created by 李佳駿 on 2017/4/4.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit
import WebKit

class ThirdViewController: UIViewController,WKNavigationDelegate {

    var webView:WKWebView!
    var indicator:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url:URL = URL(string: "http://new.cpc.com.tw/mobile/Home/")!
        let request:URLRequest = URLRequest(url: url)
        let rect = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
        webView = WKWebView(frame: rect)
        webView.load(request)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        //建立指示器物件
        let width = UIScreen.main.bounds.width / 2.0
        let hight = UIScreen.main.bounds.height / 2.0
        indicator = UIActivityIndicatorView(activityIndicatorStyle:.whiteLarge)
        indicator.color = UIColor.gray
        indicator.center = CGPoint(x: width, y: hight)
        self.webView.addSubview(indicator)
        indicator.startAnimating()

        
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicator.stopAnimating()
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
