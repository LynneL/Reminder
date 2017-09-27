//
//  CalendarViewController.swift
//  WiDok
//
//  Created by Lynn on 8/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit
import CalendarKit
import DateToolsSwift

class CalendarViewController: DayViewController {
    var eventModels:[EventModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let start = timeFormatter.date(from: "2017-08-09 10:00")!
        let end = timeFormatter.date(from: "2017-08-09 11:30")!
        let event = EventModel(start: start, end:end , meetingName: "Stand Up", location: "nono", conferenceNo: "898485935", passcode: "574")
        eventModels.append(event)

        let models = [event]
        
        var events = [Event]()
        
        for model in models {
            // Create new EventView
            let event = Event()
            event.backgroundColor = model.priority.associatedColor
            event.textColor = .white
            // Specify TimePeriod
            
            let datePeriod = TimePeriod(beginning: model.beginning, end: model.end)
            event.datePeriod = datePeriod
            // Add info: event title, subtitle, location to the array of Strings
            var info = [model.title, model.location]
            info.append("\(datePeriod.beginning!.format(with: "HH:mm")) - \(datePeriod.end!.format(with: "HH:mm"))")
            // Set "text" value of event by formatting all the information needed for display
            event.text = info.reduce("", {$0 + $1! + "\n"})
            events.append(event)
        }
        
        return events
    }

}

