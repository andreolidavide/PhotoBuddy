//
//  newApertureCalculatorView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 18/11/20.
//

import SwiftUI


struct ApertureCalculatorView: View {
    var calculatedAperture: String {
        let shutterSpeedRatio = round(log2(newShutterSpeed.rawValue / currentShutterSpeed.rawValue))
        let isoRatio = round(log2(newIso.rawValue / currentIso.rawValue))
        let newAperture = sqrt(pow(2, log2(currentAperture.rawValue * currentAperture.rawValue) + shutterSpeedRatio + isoRatio))
        print("From aperture: ISO ratio is \(isoRatio), SS ratio is \(shutterSpeedRatio) and result is \(newAperture)")
        if let optional = Aperture(rawValue: newAperture) {
            return optional.id
        } else {
            return "Out of range"
        }
    }
    
    @State var newIso: Iso
    @State var newShutterSpeed: ShutterSpeed
    @Binding var currentIso: Iso
    @Binding var currentAperture: Aperture
    @Binding var currentShutterSpeed: ShutterSpeed
    
    var body: some View {
        Picker("Shutter Speed", selection: $newShutterSpeed) {
            ForEach(ShutterSpeed.allCases) { shutterSpeed in
                Text(shutterSpeed.id).tag(shutterSpeed)
            }
        }
        Picker("ISO", selection: $newIso) {
            ForEach(Iso.allCases) { iso in
                Text(iso.id).tag(iso)
            }
        }
        Text("\(calculatedAperture)")
    }
}

/*
 struct ApertureCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        newApertureCalculatorView()
    }
}
*/
