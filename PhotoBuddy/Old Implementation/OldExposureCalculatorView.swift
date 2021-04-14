//
//  SwiftUIView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 09/11/2020.
//

import SwiftUI

class OldExposureCalculatorViewModel: ObservableObject {
    @Published var currentShutterSpeed = ExposureParameters().shutterSpeed[0]
    @Published var currentAperture = ExposureParameters().aperture[0]
    @Published var currentIso = ExposureParameters().iso[0]
}

struct OldExposureCalculatorView: View {
    
    @ObservedObject var viewModel = OldExposureCalculatorViewModel()
    
    @State private var calculationModes = ["Shutter Speed", "Aperture", "ISO"]
    @State private var selectedCalculationMode = "Shutter Speed"
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Current Exposure")){
                    Picker("Shutter Speed", selection: $viewModel.currentShutterSpeed) {
                        ForEach(ExposureParameters().shutterSpeed, id:\.self) { shutterSpeed in
                            Text(shutterSpeed).tag(shutterSpeed)
                        }
                    }
                    Picker("Aperture", selection: $viewModel.currentAperture) {
                        ForEach(ExposureParameters().aperture, id:\.self) { aperture in
                            Text(aperture).tag(aperture)
                        }
                    }
                    Picker("ISO", selection: $viewModel.currentIso) {
                        ForEach(ExposureParameters().iso, id:\.self) { iso in
                            Text(iso).tag(iso)
                        }
                    }
                }
                Section(header: Text("Equivalent Exposure")) {
                    Picker("Calculation mode", selection: $selectedCalculationMode) {
                        ForEach(calculationModes, id: \.self) { mode in
                            Text(mode).tag(mode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if selectedCalculationMode == "Shutter Speed" {
                        OldShutterSpeedCalculatorView(newIso: viewModel.currentIso, newAperture: viewModel.currentAperture, currentIso: $viewModel.currentIso, currentAperture: $viewModel.currentAperture, currentShutterSpeed: $viewModel.currentShutterSpeed)
                    }
                    else if selectedCalculationMode == "Aperture" {
                        OldApertureCalculatorView(newIso: viewModel.currentIso, newShutterSpeed: viewModel.currentShutterSpeed, currentIso: $viewModel.currentIso, currentAperture: $viewModel.currentAperture, currentShutterSpeed: $viewModel.currentShutterSpeed)
                    }
                    else {
                        OldIsoCalculatorView(newShutterSpeed: viewModel.currentShutterSpeed, newAperture: viewModel.currentAperture, currentIso: $viewModel.currentIso, currentAperture: $viewModel.currentAperture, currentShutterSpeed: $viewModel.currentShutterSpeed)
                    }

                }
            }
            .navigationBarTitle("Old Exposure Calculator")
        }

        
    }
}

struct OldExposureCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        OldExposureCalculatorView()
    }
}
