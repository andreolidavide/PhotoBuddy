//
//  Date+Extensions.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 27/11/20.
//

import Foundation

extension Date {
    
    func addDays(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}
