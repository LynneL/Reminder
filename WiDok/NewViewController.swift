//
//  NewViewController.swift
//  WiDok
//
//  Created by Lynn on 8/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    private var gradientLayer: CAGradientLayer!
    private var eventModels:[EventModel] = []
    private var event:EventModel!
    fileprivate var count = 0
    fileprivate let titleArr = ["Location", "Conference No", "Passcode", "Occurence", "Priority", "Remind"]
    fileprivate let dateTitleArr = ["Start Time"]
    fileprivate var dateArr = [String]()
    fileprivate let periodArr = ["AM", "PM"]
    fileprivate let hourArr = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    fileprivate let minuteArr = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    fileprivate var start:String = ""
    
    fileprivate var titleContent = [String]()
    fileprivate var weekStr:String = ""
    fileprivate var monthStr:String = ""
    fileprivate var picker = UIPickerView()
    fileprivate var pickerData:[[String]] = [[String]]()
    fileprivate var header = Bundle.main.loadNibNamed("OptionCell", owner: nil, options: nil)!.first as! OptionCell
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var meetingOptions: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    private var dropdownItems:[IGLDropDownItem] = []
    private var dropdownMenus:IGLDropDownMenu = IGLDropDownMenu()
    fileprivate var defaultPriority:EventPriority = .medium

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = [dateArr,periodArr, hourArr, minuteArr]
        picker.delegate = self as! UIPickerViewDelegate
        self.picker.dataSource = self as! UIPickerViewDataSource
        let today = Date()
        let calendar = Calendar.current
        var i = 0
        while i <= 365{
            let nextDay = calendar.date(byAdding: .day, value: i, to: today)
            let day = calendar.component(.day, from: nextDay!)
            let week = calendar.component(.weekday, from: nextDay!)
            let month = calendar.component(.month, from: nextDay!)
            
            for w in Utility.iterateEnum(Week.self){
                if w.rawValue == week{
                    weekStr = w.description
                }
            }
            
            for m in Utility.iterateEnum(Month.self){
                if m.rawValue == month{
                    monthStr = m.description
                }
            }
            let canChooseDay = monthStr + "\(day)" + "" + weekStr
            dateArr.append(canChooseDay)
            i += 1
        }
        

        
        meetingOptions.register(UINib(nibName: "OptionCell", bundle: nil), forCellReuseIdentifier: "OptionCell")
        header.frame = CGRect(x: 0, y: 0, width: meetingOptions.frame.width, height: 71)
        for i in 0..<titleArr.count{
            header.contentTitle.text = titleArr.first
        }
        if i >= titleArr.count{
            header.contentTitle.text = dateTitleArr.first
        }
        
        header.animationHandler = {[unowned self] input in
            self.titleContent.insert(input, at: 0)
            self.startAnimation()
        }
        header.separator.isHidden = true
        container.addSubview(header)
        saveBtn.layer.cornerRadius = 5
        callBtn.layer.cornerRadius = 5
        let item1 = IGLDropDownItem()
        item1.text = "Urgent"
        item1.backgroundColor = EventPriority.urgent.associatedColor
        item1.textLabel.textColor = .white
        let item2 = IGLDropDownItem()
        item2.text = "High"
        item2.backgroundColor = EventPriority.high.associatedColor
        item2.textLabel.textColor = .white
        let item3 = IGLDropDownItem()
        item3.text = "Medium"
        item3.backgroundColor = EventPriority.medium.associatedColor
        item3.textLabel.textColor = .white
        let item4 = IGLDropDownItem()
        item4.text = "Low"
        item4.backgroundColor = EventPriority.low.associatedColor
        item4.textLabel.textColor = .white
        dropdownItems.append(item1)
        dropdownItems.append(item2)
        dropdownItems.append(item3)
        dropdownItems.append(item4)
        

        // Do any additional setup after loading the view.
    }
    
    fileprivate func startAnimation(){
        let expend = CABasicAnimation(keyPath: "transform.scale")
        expend.beginTime = 0.3 + CACurrentMediaTime()
        expend.toValue = 1.05
        expend.duration = 0.25
        expend.fillMode=kCAFillModeForwards
        expend.isRemovedOnCompletion = false
        self.container.layer.add(expend, forKey: nil)
        UIView.animate(withDuration: 0.5, delay: 0.25, options: .allowAnimatedContent, animations: {
            self.container.frame = CGRect(origin: self.meetingOptions.frame.origin, size: CGSize(width: self.meetingOptions.frame.width, height: 71))
            
        }) { (done) in
            self.container.layer.removeAllAnimations()
            self.container.alpha = 0
            self.count += 1
            if self.count < self.titleArr.count{
                self.header.contentTF.text = nil
                self.header.contentTitle.text = self.titleArr[self.count]
            }
            self.meetingOptions.reloadData()
            UIView.animate(withDuration: 0.5, animations: {
                self.container.alpha = 1
                self.container.frame = CGRect(origin: self.topView.frame.origin, size: CGSize(width: self.topView.frame.width, height: 71))
            })
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientLayer()
        
        /*dropdownMenus.menuText = "Change Priority"
        dropdownMenus.backgroundColor = .clear
        dropdownMenus.menuButton.textLabel.textColor = .white
        dropdownMenus.menuButton.backgroundColor = defaultPriority.associatedColor
        dropdownMenus.dropDownItems = dropdownItems
        dropdownMenus.paddingLeft = 15
        dropdownMenus.type = .stack
        dropdownMenus.gutterY = 5
        dropdownMenus.animationDuration = 0.3
        dropdownMenus.itemAnimationDelay = 0.1
        dropdownMenus.rotate = .random
        dropdownMenus.direction = .up
        dropdownMenus.delegate = self
        dropdownMenus.frame = CGRect(x: containerView.bounds.width - 148,
                                     y: priorityLabel.frame.origin.y + 8,
                                     width: 140,
                                     height: 44)
        dropdownMenus.reloadView()
        containerView.addSubview(dropdownMenus)
        containerView.bringSubview(toFront: dropdownMenus)*/
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView.bounds
        gradientLayer.colors = [UIColor(colorLiteralRed: 195/255.0, green: 184/255.0, blue: 255/255.0, alpha: 1).cgColor, UIColor(red: 94.0/255.0, green: 91.0/255.0, blue: 149.0/255.0, alpha: 1).cgColor]
        self.gradientView.layer.addSublayer(gradientLayer)
    }
    
    @IBAction func saveEvent(_ sender: UIButton) {
       // self.event = EventModel(start: DateFormatter().date(from: "2017-08-09 10:00")!, end: DateFormatter().date(from: "2017-08-09 10:30")!, meetingName: meetingName.text!, location: "333", conferenceNo: conferenceNo.text!, passcode: passcode.text!)
        eventModels.append(event)

    }
    
    @IBAction func callEvent(_ sender: UIButton) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NewViewController: IGLDropDownMenuDelegate{
    func dropDownMenu(_ dropDownMenu: IGLDropDownMenu!, selectedItemAt index: Int) {
        switch index {
        case 0:
            self.defaultPriority = .urgent
        case 1:
            self.defaultPriority = .high
        case 2:
            self.defaultPriority = .medium
        default:
            self.defaultPriority = .low
        }
        dropDownMenu.menuButton.backgroundColor = self.defaultPriority.associatedColor
    }
}

extension NewViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return titleContent.count
        }else if section == 1{
            var header = Bundle.main.loadNibNamed("TimeCell", owner: nil, options: nil)!.first as! TimeCell
        }
         return dateTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
            (cell as! OptionCell).contentTF.text = titleContent[indexPath.row]
            (cell as! OptionCell).contentTitle.text = titleArr[indexPath.row]
            (cell as! OptionCell).animationHandler = {[unowned self] input in
                self.startAnimation()
            }
        }else if indexPath.section == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell
            (cell as! TimeCell).startTime.text = self.start
            (cell as! TimeCell).animationHandler = {[unowned self] input in
                self.startAnimation()
        }
        }
         return cell
    }
}

extension NewViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 71
        }else if indexPath.section == 1{
            
        }
        return 71
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 71
        }else if indexPath.section == 1{
            
        }
        return 71
    }
}


extension NewViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
 
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.start = pickerData[component][row]
    }
 }
