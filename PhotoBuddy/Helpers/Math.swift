//
//  Math.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 21/11/20.
//

import Foundation

func mod(dividend: Int, divisor: Int) -> Int {
    /*
     Reimplementation of the modulo function to work correclty even when dealing with negative integers as
     opposed to %
     */
    return dividend - (dividend/divisor) * divisor
}
