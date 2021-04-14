//
//  Aperture.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 10/11/2020.
//

import Foundation

// Aperture values are calculated as (√2)^Stop Number

enum Aperture: Double, CaseIterable, Identifiable {
    case fOverPointFive = 0.5
    case fOverPointSeven = 0.7071067812
    case fOverOne = 1
    case fOverOnePointFour = 1.414213562
    case fOverTwo = 2
    case fOverTwoPointEight = 2.828427125
    case fOverFour = 4
    case fOverFivePointSix = 5.656854249
    case fOverEight = 8
    case fOverEleven = 11.3137085
    case fOverSixteen = 16
    case fOverTwentyTwo = 22.627417
    case fOverThirtyTwo = 32
    
    var id: String {
        switch self {
        case .fOverPointFive:
            return "f/0.5"
        case .fOverPointSeven:
            return "f/0.7"
        case .fOverOne:
            return "f/1.0"
        case .fOverOnePointFour:
            return "f/1.4"
        case .fOverTwo:
            return "f/2.0"
        case .fOverTwoPointEight:
            return "f/2.8"
        case .fOverFour:
            return "f/4"
        case .fOverFivePointSix:
            return "f/5.6"
        case .fOverEight:
            return "f/8"
        case .fOverEleven:
            return "f/11"
        case .fOverSixteen:
            return "f/16"
        case .fOverTwentyTwo:
            return "f/22"
        case .fOverThirtyTwo:
            return "f/32"
        }
    }
    
    var stopNumber: Int {
        switch self {
        case .fOverPointFive:
            return -2
        case .fOverPointSeven:
            return -1
        case .fOverOne:
            return 0
        case .fOverOnePointFour:
            return 1
        case .fOverTwo:
            return 2
        case .fOverTwoPointEight:
            return 3
        case .fOverFour:
            return 4
        case .fOverFivePointSix:
            return 5
        case .fOverEight:
            return 6
        case .fOverEleven:
            return 7
        case .fOverSixteen:
            return 8
        case .fOverTwentyTwo:
            return 9
        case .fOverThirtyTwo:
            return 10
        }
    }
}
