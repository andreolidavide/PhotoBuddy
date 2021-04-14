//
//  newIsoCalculatorView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 18/11/20.
//

import SwiftUI

struct IsoCalculatorView: View {
    var calculatedIso: String {
        let shutterSpeedRatio = round(log2(currentShutterSpeed.rawValue / newShutterSpeed.rawValue))
        let apertureRatio = round(log2((newAperture.rawValue * newAperture.rawValue) / (currentAperture.rawValue * currentAperture.rawValue)))
        let newIso = round(pow(2, log2(currentIso.rawValue) + apertureRatio + shutterSpeedRatio))
        print("From iso: Aperture ratio is \(apertureRatio), SS ratio is \(shutterSpeedRatio) and result is \(newIso)")
        if let optional = Iso(rawValue: newIso) {
            return optional.id
        } else {
            return "Out of range"
        }
    }
    
    @State var newShutterSpeed: ShutterSpeed
    @State var newAperture: Aperture
    @Binding var currentIso: Iso
    @Binding var currentAperture: Aperture
    @Binding var currentShutterSpeed: ShutterSpeed
    
    var body: some View {
        Picker("Shutter Speed", selection: $newShutterSpeed) {
            ForEach(ShutterSpeed.allCases) { shutterSpeed in
                Text(shutterSpeed.id).tag(shutterSpeed)
            }
        }
        Picker("Aperture", selection: $newAperture) {
            ForEach(Aperture.allCases) { aperture in
                Text(aperture.id).tag(aperture)
            }
        }
        Text("\(calculatedIso)")
    }
}
/*
struct IsoCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        newIsoCalculatorView()
    }
}
*/
