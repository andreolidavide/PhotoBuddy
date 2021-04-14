//
//  ISO.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 10/11/2020.
//

import Foundation

enum Iso: Double, CaseIterable, Identifiable {
    case iso100 = 100
    case iso200 = 200
    case iso400 = 400
    case iso800 = 800
    case iso1600 = 1600
    case iso3200 = 3200
    case iso6400 = 6400
    
    var id: String {
        switch self {
        case .iso100:
            return "ISO 100"
        case .iso200:
            return "ISO 200"
        case .iso400:
            return "ISO 400"
        case .iso800:
            return "ISO 800"
        case .iso1600:
            return "ISO 1600"
        case .iso3200:
            return "ISO 3200"
        case .iso6400:
            return "ISO 6400"
        
        }
    }
    
    var stopNumber: Double {
        switch self {
        case .iso100:
            return 6.643856
        case .iso200:
            return 7.643856
        case .iso400:
            return 8.643856
        case .iso800:
            return 9.643856
        case .iso1600:
            return 10.643856
        case .iso3200:
            return 11.643856
        case .iso6400:
            return 12.643856
        
        }
    }
}
