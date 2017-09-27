//
//  EventModel.swift
//  WiDok
//
//  Created by Lynn on 8/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

struct EventModel {
    var beginning: Date!
    var end:Date!
    var title:String!
    var location:String!
    var priority:EventPriority = .medium
    var conferenceNo:String
    var passcode:String
    var occurence:Date!
    var reminder:Bool
    
    
    init(start:Date, end:Date, meetingName:String, location:String, conferenceNo:String, passcode:String) {
        self.beginning = start
        self.end = end
        self.title = meetingName
        self.location = location
        self.conferenceNo = conferenceNo
        self.passcode = passcode
        self.reminder = true
        
    }
}


