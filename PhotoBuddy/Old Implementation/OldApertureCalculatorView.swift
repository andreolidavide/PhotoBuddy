//
//  ApertureCalculatorView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 14/11/20.
//

import SwiftUI

struct OldApertureCalculatorView: View {
    var calculatedAperture: String {
        let shutterSpeedDifference = ExposureParameters().shutterSpeed.firstIndex(of: newShutterSpeed)! - ExposureParameters().shutterSpeed.firstIndex(of: currentShutterSpeed)!
        let isoDifference = ExposureParameters().iso.firstIndex(of: currentIso)! - ExposureParameters().iso.firstIndex(of: newIso)!
        let index = ExposureParameters().aperture.firstIndex(of: currentAperture)! - ((isoDifference + shutterSpeedDifference))
        if ExposureParameters().aperture.indices.contains(index){
            return ExposureParameters().aperture[index]
        }
        else {
            return "Out of range"
        }
    }
    
    @State var newIso: String
    @State var newShutterSpeed: String
    @Binding var currentIso: String
    @Binding var currentAperture: String
    @Binding var currentShutterSpeed: String
    
    var body: some View {
        Picker("Shutter Speed", selection: $newShutterSpeed) {
            ForEach(ExposureParameters().shutterSpeed, id:\.self) { shutterSpeed in
                Text(shutterSpeed).tag(shutterSpeed)
            }
        }
        Picker("ISO", selection: $newIso) {
            ForEach(ExposureParameters().iso, id:\.self) { iso in
                Text(iso).tag(iso)
            }
        }
        Text("\(calculatedAperture)")
    }
}

/*
struct ApertureCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        ApertureCalculatorView()
    }
}
*/
