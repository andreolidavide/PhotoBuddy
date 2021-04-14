//
//  PhotoBuddyApp.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 09/11/2020.
//

import SwiftUI

@main
struct PhotoBuddyApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView{
                ExposureCalculatorView()
                .tabItem {
                    Image(systemName: "camera.aperture")
                    Text("Exposure Calculator")
                }
                    .tag(0)
                SunHoursView()
                    .environmentObject(SunHoursViewModel())
                .tabItem {
                    Image(systemName: "sun.max")
                    Text("Sun Hours")
                }
                    .tag(1)
                
            }
        }
    
    }
}

