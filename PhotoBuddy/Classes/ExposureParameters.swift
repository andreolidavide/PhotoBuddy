//
//  ExposureParameters.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 11/11/2020.
//

import Foundation

class ExposureParameters: ObservableObject {
    let shutterSpeed = ["1/8000", "1/4000", "1/2000", "1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8", "1/4", "0\"5", "1\"", "2\"", "4\"", "8\"", "15\"", "30\""]
    let aperture = ["f/0.7", "f/1.0", "f/1.4", "f/2.0", "f/2.8", "f/4.0", "f/5.6", "f/8.0", "f/11", "f/16", "f/22", "f/32", "f/45"]
    let iso = ["ISO 100", "ISO 200", "ISO 400", "ISO 800", "ISO 1600", "ISO 3200", "ISO 6400", "ISO 12800", "ISO 25600", "ISO 51200", "ISO 102400"]
    
    let shutterSpeedForCalculations = ["1/8000", "1/4000", "1/2000", "1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8", "1/4", "0\"5", "1\"", "2\"", "4\"", "8\"", "15\"", "30\""]
//    Alternatively I could return the calculation instead --> might be better
}
