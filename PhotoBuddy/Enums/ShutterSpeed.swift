//
//  Enums.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 10/11/2020.
//

import Foundation

enum ShutterSpeed: Double, CaseIterable, Identifiable {
    case oneOverEightThousandSeconds = 0.0001220703125
    case oneOverFourThousandSeconds = 0.000244140625
    case oneOverTwoThousandSeconds = 0.00048828125
    case oneOverOneThousandSeconds = 0.0009765625
    case oneOverFiveHundredSeconds = 0.001953125
    case oneOverTwoHundredFiftySeconds = 0.00390625
    case oneOverOneHundredTwentyFiveSeconds = 0.0078125
    case oneOverSixtySeconds = 0.015625
    case oneOverThirtySeconds = 0.03125
    case oneOverFifteenSeconds = 0.0625
    case oneOverEightSeconds = 0.125
    case oneOverFourSeconds = 0.25
    case oneOverTwoSeconds = 0.5
    case oneSecond = 1
    case twoSeconds = 2
    case fourSeconds = 4
    case eightSeconds = 8
    case fifteenSeconds = 16
    case thirtySeconds = 32
    
    var id: String {
        switch self {
        case .oneOverEightThousandSeconds:
            return "1/8000"
        case .oneOverFourThousandSeconds:
            return "1/4000"
        case .oneOverTwoThousandSeconds:
            return "1/2000"
        case .oneOverOneThousandSeconds:
            return "1/1000"
        case .oneOverFiveHundredSeconds:
            return "1/500"
        case .oneOverTwoHundredFiftySeconds:
            return "1/250"
        case .oneOverOneHundredTwentyFiveSeconds:
            return "1/125"
        case .oneOverSixtySeconds:
            return "1/60"
        case .oneOverThirtySeconds:
            return "1/30"
        case .oneOverFifteenSeconds:
            return "1/15"
        case .oneOverEightSeconds:
            return "1/8"
        case .oneOverFourSeconds:
            return "1/4"
        case .oneOverTwoSeconds:
            return "1/2"
        case .oneSecond:
            return "1"
        case .twoSeconds:
            return "2"
        case .fourSeconds:
            return "4"
        case .eightSeconds:
            return "8"
        case .fifteenSeconds:
            return "15"
        case .thirtySeconds:
            return "30"
        }
    }
    
    var stopNumber: Int {
        switch self {
        case .oneOverEightThousandSeconds:
            return -13
        case .oneOverFourThousandSeconds:
            return -12
        case .oneOverTwoThousandSeconds:
            return -11
        case .oneOverOneThousandSeconds:
            return -10
        case .oneOverFiveHundredSeconds:
            return -9
        case .oneOverTwoHundredFiftySeconds:
            return -8
        case .oneOverOneHundredTwentyFiveSeconds:
            return -7
        case .oneOverSixtySeconds:
            return -6
        case .oneOverThirtySeconds:
            return -5
        case .oneOverFifteenSeconds:
            return -4
        case .oneOverEightSeconds:
            return -3
        case .oneOverFourSeconds:
            return -2
        case .oneOverTwoSeconds:
            return -1
        case .oneSecond:
            return 0
        case .twoSeconds:
            return 1
        case .fourSeconds:
            return 2
        case .eightSeconds:
            return 3
        case .fifteenSeconds:
            return 4
        case .thirtySeconds:
            return 5
        }
    }
    
}
