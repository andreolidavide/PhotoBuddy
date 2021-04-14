//
//  SunHoursRowView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 28/11/20.
//

import SwiftUI
import CoreLocation

struct SunHoursRowView: View {

    @State var sunHours: Solar
    let dateFormatter = DateFormatter(dateFormat: "dd-MM-yyyy")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(dateFormatter.string(from: sunHours.date))
            HStack {
                SunHoursCardView(hour: sunHours.sunrise!, type: "sunrise", blueHour: sunHours.blueSunrise!, goldenHour: sunHours.goldenSunrise!, civilHour: sunHours.civilSunrise!)
                SunHoursCardView(hour: sunHours.sunset!, type: "sunset", blueHour: sunHours.blueSunset!, goldenHour: sunHours.goldenSunset!, civilHour: sunHours.goldenSunset!)
            }
        }
    }
}

struct SunHoursRowView_Previews: PreviewProvider {
    static var previews: some View {
        SunHoursRowView(sunHours: Solar(coordinate: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))!)
    }
}
