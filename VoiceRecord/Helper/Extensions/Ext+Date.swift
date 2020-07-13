//
//  Ext+Date.swift
//  VoiceRecord
//
//  Created by Shashikant's_Macmini on 07/03/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

extension Date {
    
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    static var currentTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
} //extension
