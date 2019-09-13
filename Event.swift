//
//  Event.swift
//  Public Google Calendar
//
//  Created by Suyog Ghinmine on 12/09/19.
//  Copyright © 2019 Suyog Ghinmine. All rights reserved.
//

import Foundation

class Event
{
    var description : String
    var htmlLink : String
    var startDate : String
    var startTime : String?
    var endDate : String
    var endTime : String?
    init(description:String,htmlLink:String,startDate:String,startTime:String?,endDate:String,endTime : String?) {
        self.description = description
         self.htmlLink = htmlLink
         self.startDate = startDate
        self.startTime = startTime
         self.endDate = endDate
        self.endTime = endTime
    }
}
