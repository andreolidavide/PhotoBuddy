//
//  BlueGoldenHourView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 20/11/20.
//

import SwiftUI
import CoreLocation

struct SunHoursView: View {
    
    @EnvironmentObject var viewModel: SunHoursViewModel
    @State var presentExplanationView = false
    @State var presentMapView = false
    @State var showFollowingDays = false


    var body: some View {
        NavigationView{
            if viewModel.userLocation.longitude == 0 && viewModel.userLocation.latitude == 0 && viewModel.solar == Solar(coordinate: CLLocationCoordinate2D.init(latitude: 0, longitude: 0)) {
            Text("No location access")
        }
        else {
            ScrollView {
                VStack(alignment: .leading) {

                    ForEach(viewModel.sunHours, id: \.self) {
                        if $0 == viewModel.sunHours[0] {
                            Text("Today")
                                .font(.title)
                                SunHoursRowView(sunHours: viewModel.sunHours[0])
                                    .sheet(isPresented: $presentExplanationView) {
                                        SunHoursExplanationView()
                                    }

                            HStack {
                                Image(systemName: "location")
                                Text("Data calculated for \(viewModel.userLocality)")
                                    .sheet(isPresented: $presentMapView) {
                                        SunHoursSearchView()
                                    }
                            }
                            Divider()
                            Text("Coming days")
                                .font(.title)
                        } else {
                            SunHoursRowView(sunHours: $0)
                        }
   
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Sun Hours")
            .navigationBarItems(leading: Button(action: {

                self.presentMapView.toggle()

            })
                {
                    Image(systemName: "mappin.circle")
                }, trailing: Button(action: {
                    self.presentExplanationView.toggle()
            })
                {
                    Image(systemName: "questionmark.circle")
                })
        }
        }

    }
}



struct SunHoursView_Previews: PreviewProvider {
    static var previews: some View {
        SunHoursView()
            .environmentObject(SunHoursViewModel())
    }
}
