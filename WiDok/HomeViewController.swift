//
//  HomeViewController.swift
//  WiDok
//
//  Created by Lynn on 8/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var calendarView: UITableView!
    
    fileprivate let toCalendar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CAVC") as! CalendarViewController
    fileprivate var distance:CGFloat = 0 {
        didSet{
            toCalendar.dayView.timelineScrollOffset.y -= distance
        }
    }
    fileprivate var p:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.register(UINib(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "CalendarTableViewCell")
        calendarView.estimatedRowHeight = 400
        calendarView.panGestureRecognizer.addTarget(self, action: #selector(updateDistance))
    }
    
    @objc fileprivate func updateDistance(sender:UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            p = sender.location(in: view)
            distance = 0
        case .changed:
            distance += sender.location(in: view).y - p.y
            p = sender.location(in: view)
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toCalendar.view.frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.bounds.width, height: view.bounds.height - 30))
        calendarView.rowHeight = 10000
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
        toCalendar.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 1000)
        cell.contentView.addSubview(toCalendar.view)
        return cell
    }
}

extension HomeViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 200 {
            scrollView.contentOffset = CGPoint(x: 0, y: 200)
        }
    }
}
