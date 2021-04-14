//
//  SunHoursMapView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 04/12/20.
//

import SwiftUI
import MapKit

struct SunHoursMapView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: SunHoursViewModel
    @State var userTrackingMode = MapUserTrackingMode.follow

    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $viewModel.userRegion, showsUserLocation: true, userTrackingMode: $userTrackingMode)
                .navigationBarTitle(Text("Change location"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                    {
                        Text("Dismiss")
                    })
        }
    }
}

struct SunHoursMapView_Previews: PreviewProvider {
    static var previews: some View {
        SunHoursMapView()
            .environmentObject(SunHoursViewModel())
    }
}
