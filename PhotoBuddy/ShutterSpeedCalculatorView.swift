//
//  newShutterSpeedCalculatorView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 18/11/20.
//

import SwiftUI

struct ShutterSpeedCalculatorView: View {
    var calculatedShutterSpeed: String {
        let apertureRatio = round(log2((newAperture.rawValue * newAperture.rawValue) / (currentAperture.rawValue * currentAperture.rawValue)))
        let isoRatio = round(log2(currentIso.rawValue / newIso.rawValue))
        let newShutterSpeed = pow(2, log2(currentShutterSpeed.rawValue) + apertureRatio + isoRatio)
        print(newAperture.rawValue)
        print("From shutter: Aperture ratio is \(apertureRatio), ISO ratio is \(isoRatio) and result is \(newShutterSpeed)")
        if let optional = ShutterSpeed(rawValue: newShutterSpeed) {
            return optional.id
        } else {
            return "Out of range"
        }
        
    }
    
    @State var newIso: Iso
    @State var newAperture: Aperture
    @Binding var currentIso: Iso
    @Binding var currentAperture: Aperture
    @Binding var currentShutterSpeed: ShutterSpeed
    
    var body: some View {
        Picker("Aperture", selection: $newAperture) {
            ForEach(Aperture.allCases) { aperture in
                Text(aperture.id).tag(aperture)
            }
        }
        Picker("ISO", selection: $newIso) {
            ForEach(Iso.allCases) { iso in
                Text(iso.id).tag(iso)
            }
        }
        Text("\(calculatedShutterSpeed)")
    }
}
/*
struct ShutterSpeedCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        newShutterSpeedCalculatorView()
    }
}
*/
