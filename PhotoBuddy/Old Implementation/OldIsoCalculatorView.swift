//
//  IsoCalculatorView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 15/11/20.
//

import SwiftUI

struct OldIsoCalculatorView: View {
    var calculatedIso: String {
        let shutterSpeedDifference = ExposureParameters().shutterSpeed.firstIndex(of: newShutterSpeed)! - ExposureParameters().shutterSpeed.firstIndex(of: currentShutterSpeed)!
        let apertureDifference = ExposureParameters().aperture.firstIndex(of: currentAperture)! - ExposureParameters().aperture.firstIndex(of: newAperture)!
        let index = ExposureParameters().iso.firstIndex(of: currentIso)! - ((apertureDifference + shutterSpeedDifference))
        if ExposureParameters().iso.indices.contains(index){
            return ExposureParameters().iso[index]
        }
        else {
            return "Out of range"
        }
    }
    
    @State var newShutterSpeed: String
    @State var newAperture: String
    @Binding var currentIso: String
    @Binding var currentAperture: String
    @Binding var currentShutterSpeed: String
    
    var body: some View {
        Picker("Shutter Speed", selection: $newShutterSpeed) {
            ForEach(ExposureParameters().shutterSpeed, id:\.self) { shutterSpeed in
                Text(shutterSpeed).tag(shutterSpeed)
            }
        }
        Picker("Aperture", selection: $newAperture) {
            ForEach(ExposureParameters().aperture, id:\.self) { aperture in
                Text(aperture).tag(aperture)
            }
        }
        Text("\(calculatedIso)")
    }
}
/*
struct IsoCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        IsoCalculatorView()
    }
}
*/
