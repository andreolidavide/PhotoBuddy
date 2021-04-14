//
//  BlueGoldenHourExplanationView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 27/11/20.
//

import SwiftUI

struct SunHoursExplanationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Text("What are these \"magic\" hours?")
                            .font(.title)
                        Text("They are phases in which the sky has a particular hue, thanks to the angle of the sun. Their timing and duration depends on a lot of factors, but mostly on the location you are in.")
                    }
                    Group {
                        Text("How are the magic hours calculated?")
                            .font(.title)
                        Text("The different twilight phases are defined based on the angle of the sun with respect to the horizon. The phases used in this app are the following:")
                        Group {
                            Text("• Morning blue hour: from -6° to -4°")
                            Text("• Morning golden hour: from -4° to 6°")
                            Text("• Sunrise: exactly 0°")
                            Text("• Daytime: over 6°")
                            Text("• Evening golden hour: from 6° to -4°")
                            Text("• Evening golden hour: from -4° to -6°")
                            Text("• Civil sunset: below -6°")
                            Text("• Sunset: exactly 0°")
                        }
                        
                    }
                    Group {
                        Text("Why is there only one time, if the magic hour has a longer duration")
                            .font(.title)
                        Text("The time indicates the beginning of the phase, the duration can be easily derivated by the time between the different phases. Morning blue hour for example will start at the indicated time, and will end at the start of morning golden hour. Morning golden hour will end at the start of daytime.")
                    }
                    Group {
                        Text("How precise are they?")
                            .font(.title)
                        Text("The biggest approximation in the calculation is that the sun is considered as a point, so the calculations are correct for the center of the sun, but you might see the edges of the disk a bit sooner or a bit later. \nThe magic hours themselves are precise in the sense that the center of the sun will be at the angle which specifies the beginning of the \"zone\",  but they are still supposed to be indicative since the color of the sky will depend on a lot of factors as weather condition, pollution and so on. It's better to be there a bit in advance just to be sure.")
                    }

                    Spacer()
                }
                    .padding()
                    .navigationBarTitle("Explanation")
                    .navigationBarItems(trailing: Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                        {
                            Text("Dismiss")
                        })
            }
        }
    }
}

struct SunHoursxplanationView_Previews: PreviewProvider {
    static var previews: some View {
        SunHoursExplanationView()
    }
}

