//
//  newExposureCalculatorView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 18/11/20.
//

import SwiftUI

class ExposureCalculatorViewModel: ObservableObject {
    @Published var currentShutterSpeed = ShutterSpeed.oneOverFourThousandSeconds
    @Published var currentAperture = Aperture.fOverPointSeven
    @Published var currentIso = Iso.iso100
}

struct ExposureCalculatorView: View {
    @ObservedObject var viewModel = ExposureCalculatorViewModel()
    
    @State private var calculationModes = ["Shutter Speed", "Aperture", "ISO"]
    @State private var selectedCalculationMode = "Shutter Speed"
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Current Exposure")){
                    Picker("Shutter Speed", selection: $viewModel.currentShutterSpeed) {
                        ForEach(ShutterSpeed.allCases) { shutterSpeed in
                            Text(shutterSpeed.id).tag(shutterSpeed)
                        }
                    }
                    Picker("Aperture", selection: $viewModel.currentAperture) {
                        ForEach(Aperture.allCases) { aperture in
                            Text(aperture.id).tag(aperture)
                        }
                    }
                    Picker("ISO", selection: $viewModel.currentIso) {
                        ForEach(Iso.allCases) { iso in
                            Text(iso.id).tag(iso)
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
                        ShutterSpeedCalculatorView(newIso: viewModel.currentIso, newAperture: viewModel.currentAperture, currentIso: $viewModel.currentIso, currentAperture: $viewModel.currentAperture, currentShutterSpeed: $viewModel.currentShutterSpeed)
                    }
                    else if selectedCalculationMode == "Aperture" {
                        ApertureCalculatorView(newIso: viewModel.currentIso, newShutterSpeed: viewModel.currentShutterSpeed, currentIso: $viewModel.currentIso, currentAperture: $viewModel.currentAperture, currentShutterSpeed: $viewModel.currentShutterSpeed)
                    }
                    else {
                        IsoCalculatorView(newShutterSpeed: viewModel.currentShutterSpeed, newAperture: viewModel.currentAperture, currentIso: $viewModel.currentIso, currentAperture: $viewModel.currentAperture, currentShutterSpeed: $viewModel.currentShutterSpeed)
                    }

                }
            }
            .navigationBarTitle("Exposure Calculator")
        }

        
    }
}

struct newExposureCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        ExposureCalculatorView()
    }
}
