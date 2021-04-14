//
//  SunsetCardView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 27/11/20.
//

import SwiftUI
import CoreLocation

struct SunHoursCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: SunHoursViewModel
    @State var hour: Date
    @State var type: String
    @State var blueHour: Date
    @State var goldenHour: Date
    @State var civilHour: Date

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: type)
                    .font(.system(size: 32, weight: .regular))
                Text(viewModel.dateFormatter.string(from: hour))
            }
            Divider()
                .frame(maxWidth: 50)
            if type == "sunrise" {
                HStack {
                    Text("Blue hour").font(.headline)
                    Text("\(viewModel.dateFormatter.string(from: civilHour))")
                }
                HStack {
                    Text("Golden hour").font(.headline)
                    Text("\(viewModel.dateFormatter.string(from: blueHour))")
                }
                HStack {
                    Text("Daytime").font(.headline)
                    Text("\(viewModel.dateFormatter.string(from: goldenHour))")
                }
                
            } else {
                HStack {
                    Text("Golden hour").font(.headline)
                    Text("\(viewModel.dateFormatter.string(from: goldenHour))")
                }
                HStack {
                    Text("Blue hour").font(.headline)
                    Text("\(viewModel.dateFormatter.string(from: blueHour))")
                }
                HStack {
                    Text("Civil \(type)").font(.headline)
                    Text("\(viewModel.dateFormatter.string(from: civilHour))")
                }
            }

            
        }
        .padding([.vertical, .horizontal], 10)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)

    }
}

struct SunHoursCardView_Previews: PreviewProvider {
    static var previews: some View {
        SunHoursCardView(hour: Date(), type: "sunrise", blueHour: Date(), goldenHour: Date(), civilHour: Date())
            .environmentObject(SunHoursViewModel())
    }
}
