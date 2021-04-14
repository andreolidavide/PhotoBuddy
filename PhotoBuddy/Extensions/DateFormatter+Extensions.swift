//
//  DateFormatter+Extensions.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 28/11/20.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
