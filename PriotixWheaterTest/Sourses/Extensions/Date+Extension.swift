//
//  Date+Extension.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation

extension Date {
    
    func wt_dayFormat() -> String {
        let format = DateFormatter()
        format.dateFormat = "M/d"
        return format.string(from: self)
    }
    
    func wt_hoursFormat() -> String {
        let format = DateFormatter()
        format.dateFormat = "HH"
        return format.string(from: self)+"h"
    }
    
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
}
