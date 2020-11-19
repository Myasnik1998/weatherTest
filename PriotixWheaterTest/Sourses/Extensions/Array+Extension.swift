//
//  Array+Extension.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
    
}
