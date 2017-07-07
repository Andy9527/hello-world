//
//  OffendersViewController.swift
//  PrisonerManagement
//
//  Created by 李佳駿 on 2017/7/3.
//  Copyright © 2017年 李佳駿. All rights reserved.
//

import UIKit

class OffendersViewController: UIViewController {

    @IBOutlet var TrueNameLabel: UILabel!
    @IBOutlet var BirthInfoLabel: UILabel!
    @IBOutlet var SexLabel: UILabel!
    @IBOutlet var CitizenshipLabel: UILabel!
    @IBOutlet var LevelLabel: UILabel!
    @IBOutlet var HightLabel: UILabel!
    @IBOutlet var WeightLabel: UILabel!
    @IBOutlet var SkinfairLabel: UILabel!
    @IBOutlet var EyecolorLabel: UILabel!
    @IBOutlet var HaircolorLabel: UILabel!
    @IBOutlet var HairlenghLabel: UILabel!
    @IBOutlet var FacialhairLabel: UILabel!
    @IBOutlet var BuildLabel: UILabel!
    @IBOutlet var PhoneLabel: UILabel!
    @IBOutlet var MobileLabel: UILabel!
    
    @IBOutlet var IdentifyingMarksLabel: UILabel!
    @IBOutlet var HatLabel: UILabel!
    @IBOutlet var JewelryLabel: UILabel!
    @IBOutlet var ShirtLabel: UILabel!
    @IBOutlet var FootwearLabel: UILabel!
    
    
    
    
    
    
    //手勢物件
    var registrationsGes:UITapGestureRecognizer!
    var offendersSearchGes:UITapGestureRecognizer!
    var offendersGes:UITapGestureRecognizer!
    var calendarGes:UITapGestureRecognizer!
    var messageGes:UITapGestureRecognizer!
    var settingGes:UITapGestureRecognizer!
    
    //CoverView物件
    var registrationCoverView:UIView!
    var offendersSearchCoverView:UIView!
    var offendersCoverView:UIView!
    var calendarCoverView:UIView!
    var messageCoverView:UIView!
    var settingCoverView:UIView!
    
    //Label物件
    var registrationLabel:UILabel!
    var offendersSearchLabel:UILabel!
    var offendersLabel:UILabel!
    var calendarLabel:UILabel!
    var messageLabel:UILabel!
    var settingLabel:UILabel!
    
    //ImageView物件
    var registrationImage:UIImageView!
    var offendersSearchImage:UIImageView!
    var offendersImage:UIImageView!
    var calendarImage:UIImageView!
    var messageImage:UIImageView!
    var settingImage:UIImageView!
    
    //View物件
    var registrationView:UIView!
    var offendersSearchView:UIView!
    var offendersView:UIView!
    var calendarView:UIView!
    var messageView:UIView!
    var settingView:UIView!

    
    @IBAction func MenuBtn(_ sender: Any)
    {
        //建立手勢物件
        registrationsGes = UITapGestureRecognizer(target: self, action: #selector(registraionsSelector(_:)))
        //設定點擊次數
        registrationsGes.numberOfTapsRequired = 1
        //建立要覆蓋上去的view以及加上手勢
        registrationCoverView = UIView(frame: CGRect(x: 0.0, y: 60.0, width: 138.0, height: 138.0))
        registrationCoverView.addGestureRecognizer(registrationsGes)
        //啟動可以被點擊
        registrationCoverView.isUserInteractionEnabled = true
        //建立RegistrationView
        registrationView = UIView(frame: CGRect(x: 0.0, y: 60.0, width: 138.0, height: 138.0))
        //設定背景顏色
        registrationView.backgroundColor = UIColor(red: 60.0/255, green: 78.0/255, blue: 255.0/255, alpha: 1.0)
        //建立RegistraionImage
        registrationImage = UIImageView(frame: CGRect(x: 49.0, y: 35.0, width: 40.0, height: 40.0))
        registrationImage.backgroundColor = UIColor.white
        //建立RegistrationLabel
        registrationLabel = UILabel(frame: CGRect(x: 4.0, y: 80.0, width: 130.0, height: 30.0))
        //設定文字
        registrationLabel.text = "Registrations"
        //設定字型與大小
        registrationLabel.font = UIFont(name: "Helvetica", size: 16.0)
        //設定置中
        registrationLabel.textAlignment = NSTextAlignment.center
        //設定文字顏色
        registrationLabel.textColor = UIColor.white
        //設定行數
        registrationLabel.numberOfLines = 3
        
        //registrationImage and registrationLabel 加到resgistrationView
        self.registrationView.addSubview(self.registrationImage)
        self.registrationView.addSubview(self.registrationLabel)
        //將registrationView and 要覆蓋上去的view加到 self.view
        self.view.addSubview(self.registrationView)
        self.view.addSubview(self.registrationCoverView)
        
        
        //建立手勢物件
        offendersSearchGes = UITapGestureRecognizer(target: self, action:#selector(offendersSearchSelector(_:)))
        //設定點擊次數
        offendersSearchGes.numberOfTapsRequired = 1
        //建立要覆蓋offendersSearch的view以及加上手勢
        offendersCoverView = UIView(frame: CGRect(x: 138.0, y: 60.0, width: 138.0, height: 138.0))
        offendersCoverView.addGestureRecognizer(self.offendersSearchGes)
        //啟動可以被點擊
        offendersCoverView.isUserInteractionEnabled = true
        //建立offendersSearchView物件
        offendersSearchView = UIView(frame: CGRect(x: 138.0, y: 60.0, width: 138.0, height: 138.0))
        //設定背景顏色
        offendersSearchView.backgroundColor = UIColor(red: 85.0/255, green: 139.0/255, blue: 255.0/255, alpha: 1.0)
        //建立offendersSearchView物件
        offendersSearchImage = UIImageView(frame: CGRect(x: 49.0, y: 35.0, width: 40.0, height: 40.0))
        offendersSearchImage.backgroundColor = UIColor.white
        //建立offendersLabel物件
        offendersSearchLabel = UILabel(frame: CGRect(x: 4.0, y: 80.0, width: 130.0, height: 30.0))
        //設定文字
        offendersSearchLabel.text = "Offenders Search"
        //設定字型與大小
        offendersSearchLabel.font = UIFont(name: "Helvetica", size: 16.0)
        //設定置中
        offendersSearchLabel.textAlignment = NSTextAlignment.center
        //設定文字顏色
        offendersSearchLabel.textColor = UIColor.white
        //設定行數
        offendersSearchLabel.numberOfLines = 3
        //將offendersLabel and offendersImage加入offendersView
        self.offendersSearchView.addSubview(self.offendersSearchImage)
        self.offendersSearchView.addSubview(self.offendersSearchLabel)
        //將offendersView and要覆蓋offendersView的view加入self.view
        self.view.addSubview(self.offendersSearchView)
        self.view.addSubview(self.offendersCoverView)
        
        //建立手勢物件
        offendersGes = UITapGestureRecognizer(target: self, action: #selector(offendersSelector(_:)))
        //設定點擊次數
        offendersGes.numberOfTapsRequired = 1
        //建立要覆蓋offendersView的view以及加上手勢
        offendersCoverView = UIView(frame: CGRect(x: 276.0, y: 60.0, width: 138.0, height: 138.0))
        offendersCoverView.addGestureRecognizer(self.offendersGes)
        //啟動可以被點擊
        offendersCoverView.isUserInteractionEnabled = true
        //建立offendersView物件
        self.offendersView = UIView(frame: CGRect(x: 276.0, y: 60.0, width: 138.0, height: 138.0))
        //設定背景顏色
        self.offendersView.backgroundColor = UIColor(red: 115.0/255, green: 186.0/255, blue: 255.0/255, alpha: 1.0)
        //建立offendersImageView物件
        self.offendersImage = UIImageView(frame: CGRect(x: 49.0, y: 35.0, width: 40.0, height: 40.0))
        self.offendersImage.backgroundColor = UIColor.white
        //建立offendersLabel物件
        self.offendersLabel = UILabel(frame: CGRect(x: 4.0, y: 80.0, width: 130.0, height: 30.0))
        //設定文字
        offendersLabel.text = "Offenders"
        //設定字型與大小
        offendersLabel.font = UIFont(name: "Helvetica", size: 16.0)
        //設定置中
        offendersLabel.textAlignment = NSTextAlignment.center
        //設定文字顏色
        offendersLabel.textColor = UIColor.white
        //設定行數
        offendersLabel.numberOfLines = 3
        //將offendersLabel and offendersImage加到offendersView
        self.offendersView.addSubview(self.offendersImage)
        self.offendersView.addSubview(self.offendersLabel)
        //將offendersView and要覆蓋offendersView的view加入self.view
        self.view.addSubview(self.offendersView)
        self.view.addSubview(self.offendersCoverView)
        
        
        //建立手勢物件
        calendarGes = UITapGestureRecognizer(target: self, action: #selector(calendarSelector(_:)))
        //設定點擊次數
        calendarGes.numberOfTapsRequired = 1
        //建立要覆蓋caledarView的view以及加上手勢
        calendarCoverView = UIView(frame: CGRect(x: 0.0, y: 198.0, width: 138.0, height: 138.0))
        calendarCoverView.addGestureRecognizer(self.calendarGes)
        //啟動可以被點擊
        calendarCoverView.isUserInteractionEnabled = true
        //建立calendarView物件
        calendarView = UIView(frame: CGRect(x: 0.0, y: 198.0, width: 138.0, height: 138.0))
        //設定背景顏色
        calendarView.backgroundColor = UIColor(red: 31.0/255, green: 168.0/255, blue: 255.0/255, alpha: 1.0)
        //建立calendarImageView物件
        calendarImage = UIImageView(frame: CGRect(x: 49.0, y: 35.0, width: 40.0, height: 40.0))
        calendarImage.backgroundColor = UIColor.white
        calendarLabel = UILabel(frame: CGRect(x: 4.0, y: 80.0, width: 130.0, height: 30.0))
        //設定文字
        calendarLabel.text = "Calendar"
        //設定字型與大小
        calendarLabel.font = UIFont(name: "Helvetica", size: 16.0)
        //設定置中
        calendarLabel.textAlignment = NSTextAlignment.center
        //設定文字顏色
        calendarLabel.textColor = UIColor.white
        //設定行數
        calendarLabel.numberOfLines = 3
        //將calendarLabel and calendarImage 加入calendarView
        self.calendarView.addSubview(self.calendarImage)
        self.calendarView.addSubview(self.calendarLabel)
        //將calendarview  and 要覆蓋calendarView的view加入self.view
        self.view.addSubview(self.calendarView)
        self.view.addSubview(self.calendarCoverView)
        
        //建立手勢物件
        messageGes = UITapGestureRecognizer(target: self, action: #selector(messageSelector(_:)))
        //設定點擊次數
        messageGes.numberOfTapsRequired = 1
        //建立要覆蓋messageView的view以及加上手勢
        messageCoverView = UIView(frame: CGRect(x: 138.0, y: 198.0, width: 138.0, height: 138.0))
        messageCoverView.addGestureRecognizer(self.messageGes)
        //啟動可以被點擊
        messageCoverView.isUserInteractionEnabled = true
        
        //建立messageView
        messageView = UIView(frame: CGRect(x: 138.0, y: 198.0, width: 138.0, height: 138.0))
        //設定背景顏色
        messageView.backgroundColor = UIColor(red: 67.0/255, green: 254.0/255, blue: 255.0/255, alpha: 1.0)
        //建立messageImage物件
        messageImage = UIImageView(frame: CGRect(x: 49.0, y: 35.0, width: 40.0, height: 40.0))
        messageImage.backgroundColor = UIColor.white
        //建立messageLabel物件
        messageLabel = UILabel(frame: CGRect(x: 4.0, y: 80.0, width: 130.0, height: 30.0))
        //設定文字
        messageLabel.text = "Message"
        //設定字型與大小
        messageLabel.font = UIFont(name: "Helvetica", size: 16.0)
        //設定置中
        messageLabel.textAlignment = NSTextAlignment.center
        //設定文字顏色
        messageLabel.textColor = UIColor.white
        //設定行數
        messageLabel.numberOfLines = 3
        //將messageLabel and messageImage加到messageView
        self.messageView.addSubview(self.messageImage)
        self.messageView.addSubview(self.messageLabel)
        //將messageView以及要覆蓋messageView的view加入self.view
        self.view.addSubview(self.messageView)
        self.view.addSubview(self.messageCoverView)
        
        
        //建立手勢物件
        settingGes = UITapGestureRecognizer(target: self, action: #selector(settingSelector(_:)))
        //設定點擊次數
        settingGes.numberOfTapsRequired = 1
        //建立要覆蓋settingView上去的view以及加上手勢
        settingCoverView = UIView(frame: CGRect(x: 276.0, y: 198.0, width: 138.0, height: 138.0))
        settingCoverView.addGestureRecognizer(self.settingGes)
        //啟動可以被點擊
        settingCoverView.isUserInteractionEnabled = true
        
        //建立settingView物件
        settingView = UIView(frame: CGRect(x: 276.0, y: 198.0, width: 138.0, height: 138.0))
        //設定背景顏色
        settingView.backgroundColor = UIColor(red: 145.0/255, green: 191.0/255, blue: 255.0/255, alpha: 1.0)
        //建立settingImageView物件
        settingImage = UIImageView(frame: CGRect(x: 49.0, y: 35.0, width: 40.0, height: 40.0))
        settingImage.backgroundColor = UIColor.white
        //建立settingLabel物件
        settingLabel = UILabel(frame: CGRect(x: 4.0, y: 80.0, width: 130.0, height: 30.0))
        //設定文字
        settingLabel.text = "Setting"
        //設定字型與大小
        settingLabel.font = UIFont(name: "Helvetica", size: 16.0)
        //設定置中
        settingLabel.textAlignment = NSTextAlignment.center
        //設定文字顏色
        settingLabel.textColor = UIColor.white
        //設定行數
        settingLabel.numberOfLines = 3
        //將settingLabel and settingImage 加入 settingView
        self.settingView.addSubview(self.settingImage)
        self.settingView.addSubview(self.settingLabel)
        //將settingView and要覆蓋在settingView上面的view加入self.view
        self.view.addSubview(self.settingView)
        self.view.addSubview(self.settingCoverView)
        

    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.TrueNameLabel.text = "Montgomery Burns"
        self.BirthInfoLabel.text = "05/2/1915 102years"
        self.SexLabel.text = "Male"
        self.CitizenshipLabel.text = "United States"
        self.LevelLabel.text = "Full Post"
        self.HightLabel.text = "5'8''"
        self.WeightLabel.text = "130lbs"
        self.SkinfairLabel.text = "Fair"
        self.EyecolorLabel.text = "Brown"
        self.HaircolorLabel.text = "White"
        self.HairlenghLabel.text = "Short"
        self.FacialhairLabel.text = "Goatee"
        self.BuildLabel.text = "Frail"
        self.PhoneLabel.text = "(555)555-5223"
        self.MobileLabel.text = "(555)555-5223"
        self.IdentifyingMarksLabel.text = "Tattoo on lower back"
        self.HatLabel.text = "Bowler Hat"
        self.JewelryLabel.text = "Rolex Watch"
        self.ShirtLabel.text = "White Dress Shirt"
        self.FootwearLabel.text = "Black leather wingtips"
        
       
    
    }
    
    //隱藏狀態列
    override var prefersStatusBarHidden: Bool
    {
        return true
    }


    //螢幕旋轉
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    //registraionsSelector
    func registraionsSelector(_ sender:UITapGestureRecognizer)
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let regitrationVC = storyboard.instantiateViewController(withIdentifier: "registrations")
        self.present(regitrationVC, animated: true, completion: nil)
        
        
    }
    //offenders search selector
    func offendersSearchSelector(_ sender:UITapGestureRecognizer)
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let offendersSearchVC = storyboard.instantiateViewController(withIdentifier: "offendersSearch")
        self.present(offendersSearchVC, animated: true, completion: nil)
        
    }
    //offenders selector
    func offendersSelector(_ sener:UITapGestureRecognizer)
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let offendersVC = storyboard.instantiateViewController(withIdentifier: "offenders")
        self.present(offendersVC, animated: true, completion: nil)
        
        
        
    }
    func messageSelector(_ sender:UITapGestureRecognizer)
    {
        print("有")
    }
    // calenar selector
    func calendarSelector(_ sener:UITapGestureRecognizer)
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let calenarVC = storyboard.instantiateViewController(withIdentifier: "calendar")
        self.present(calenarVC, animated: true, completion: nil)
    }
    //setting selector
    func settingSelector(_ sender:UITapGestureRecognizer)
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingVC = storyboard.instantiateViewController(withIdentifier: "setting")
        self.present(settingVC, animated: true, completion: nil)
        
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
