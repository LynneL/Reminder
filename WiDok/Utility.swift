
//
//  Utility.swift
//  WiDok
//
//  Created by Lynn on 8/9/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

struct Utility {
    
    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
}

enum Week:Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wendsday
    case Thursday
    case Friday
    case Saturday
    
}

extension Week {
    
    var description:String {
        switch self {
        case .Sunday:
            return "Sun"
        case .Monday:
            return "Mon"
        case .Tuesday:
            return "Tue"
        case .Wendsday:
            return "Wen"
        case.Thursday:
            return "Thu"
        case .Friday:
            return "Fri"
        case .Saturday:
            return "Sat"
        }
    }
    
}

enum Month:Int {
    case Jan = 1
    case Feb
    case Mar
    case Apr
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
}

extension Month {
    var description:String {
        switch self {
        case .Jan:
            return "Jan"
        case .Feb:
            return "Feb"
        case .Mar:
            return "Mar"
        case .Apr:
            return "Apr"
        case .May:
            return "May"
        case .Jun:
            return "Jun"
        case .Jul:
            return "Jul"
        case .Aug :
            return "Aug"
        case .Sep:
            return "Sep"
        case .Oct:
            return "Oct"
        case .Nov:
            return "Nov"
        case .Dec:
            return "Dec"
        }
    }
}

