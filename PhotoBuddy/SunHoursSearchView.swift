//
//  SunHoursSearchView.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 04/12/20.
//

import SwiftUI
import MapKit

struct SunHoursSearchView: View {
    @ObservedObject var locationService = LocationService()
    @EnvironmentObject var viewModel: SunHoursViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Location Search")) {
                        ZStack(alignment: .trailing) {
                            TextField("Search", text: $locationService.queryFragment)
                            // This is optional and simply displays an icon during an active search
                            if locationService.status == .isSearching {
                                Image(systemName: "clock")
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                    Section(header: Text("Results")) {
                        List {
                            // With Xcode 12, this will not be necessary as it supports switch statements.
                            switch locationService.status {
                                case .noResults:
                                    AnyView(Text("No Results"))
                                case .error(let description):
                                    AnyView(Text("Error: \(description)"))
                                default: AnyView(EmptyView())
                            }
                            ForEach(locationService.searchResults, id: \.self) { completionResult in
                                // This simply lists the results, use a button in case you'd like to perform an action
                                // or use a NavigationLink to move to the next view upon selection.
                                Button(action: {self.updateLocation(search: completionResult)}) {
                                    HStack {
                                        Text("\(completionResult.title), \(completionResult.subtitle)")
                                        Spacer()
                                        Image(systemName: "arrow.forward")
                                    }

                                }
                                .buttonStyle(PlainButtonStyle())
                                .fullScreenCover(isPresented: $viewModel.isLoading, content: {
                                    ProgressView()
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateLocation(search: MKLocalSearchCompletion) {
        viewModel.updateLocation(search: search)
        
    }
}

struct SunHoursSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SunHoursSearchView(locationService: LocationService())
    }
}
