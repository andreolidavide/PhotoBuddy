//
//  ShutterSpeedCalculatorView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 10/11/2020.
//

import SwiftUI

struct OldShutterSpeedCalculatorView: View {
    
    var calculatedShutterSpeed: String {
        let apertureDifference = ExposureParameters().aperture.firstIndex(of: newAperture)! - ExposureParameters().aperture.firstIndex(of: currentAperture)!
        let isoDifference = ExposureParameters().iso.firstIndex(of: currentIso)! - ExposureParameters().iso.firstIndex(of: newIso)!
        let index = ExposureParameters().shutterSpeed.firstIndex(of: currentShutterSpeed)! + ((isoDifference + apertureDifference))
        if ExposureParameters().shutterSpeed.indices.contains(index){
            return ExposureParameters().shutterSpeed[index]
        }
        else {
            return "Out of range"
        }
    }
    
    @State var newIso: String
    @State var newAperture: String
    @Binding var currentIso: String
    @Binding var currentAperture: String
    @Binding var currentShutterSpeed: String
    
    var body: some View {
        Picker("Aperture", selection: $newAperture) {
            ForEach(ExposureParameters().aperture, id:\.self) { aperture in
                Text(aperture).tag(aperture)
            }
        }
        Picker("ISO", selection: $newIso) {
            ForEach(ExposureParameters().iso, id:\.self) { iso in
                Text(iso).tag(iso)
            }
        }
        Text("\(calculatedShutterSpeed)")
    }
}

/*
struct ShutterSpeedCalculatorView_Previews: PreviewProvider {

    static var previews: some View {
        ShutterSpeedCalculatorView(newIso: "ISO 100", newAperture: "f/0.7", currentIso: "ISO 100", currentAperture: "f/0.7", currentShutterSpeed: "1/2000")
    }
}
*/
