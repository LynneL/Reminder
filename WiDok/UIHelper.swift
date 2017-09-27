
//
//  UIHelper.swift
//  WiDok
//
//  Created by Lynn on 8/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

enum EventPriority {
    case urgent
    case high
    case medium
    case low
}

extension EventPriority{
    var associatedColor:UIColor{
        switch self {
        case .urgent:
            return UIColor(colorLiteralRed: 242/255.0, green: 130/255.0, blue: 135/255.0, alpha: 1)
        case .high:
            return UIColor(colorLiteralRed: 243/255.0, green: 144/255.0, blue: 48/255.0, alpha: 1)
        case .medium:
            return UIColor(colorLiteralRed: 164/255.0, green: 218/255.0, blue: 255/255.0, alpha: 1)
        default:
            return UIColor(colorLiteralRed: 154/255.0, green: 214/255.0, blue: 126/255.0, alpha: 1)
        }
    }
}
