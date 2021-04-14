//
//  SearchLocationService.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 04/12/20.
//

import Foundation
import Combine
import MapKit

/*class LocationService: NSObject, ObservableObject {
    enum LocationStatus: Equatable {
        case idle
        case noResults
        case isSearching
        case error(String)
        case result
    }
    
    @Published var queryFragment: String = ""
    @Published private(set) var status: LocationStatus = .idle
    @Published private(set) var searchResults: [MKMapItem] = []
    
    private var queryCancellable: AnyCancellable?
    private let searcher: MKLocalSearch.Request
    
    init(searcher: MKLocalSearch.Request = MKLocalSearch.Request()) {
        self.searcher = searcher
        super.init()
        queryCancellable = $queryFragment
            .receive(on: DispatchQueue.main)
            // we're debouncing the search, because the search completer is rate limited.
            // feel free to play with the proper value here
            .debounce(for: .milliseconds(250), scheduler: RunLoop.main, options: nil)
            .sink(receiveValue: { fragment in
                self.status = .isSearching
                if !fragment.isEmpty {
                    self.searcher.naturalLanguageQuery = fragment

                    let search = MKLocalSearch(request: searcher)
                    search.start { (response, error) in
                        guard let response = response else {
                            self.status = .error((error?.localizedDescription)!)
                            return
                        }
                        print(response.mapItems)
                        self.searchResults = response.mapItems
                        self.status = .idle
                        /*for item in response.mapItems {
                            if let name = item.name,
                                let location = item.placemark.location {
                                print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                            }
                        }*/
                    }
                } else {
                    self.status = .idle
                    self.searchResults = []
                }
        })
    }
}
*/

class LocationService: NSObject, ObservableObject {

    enum LocationStatus: Equatable {
        case idle
        case noResults
        case isSearching
        case error(String)
        case result
    }

    @Published var queryFragment: String = ""
    @Published private(set) var status: LocationStatus = .idle
    @Published private(set) var searchResults: [MKLocalSearchCompletion] = []

    private var queryCancellable: AnyCancellable?
    private let searchCompleter: MKLocalSearchCompleter!

    init(searchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()) {
        self.searchCompleter = searchCompleter
        super.init()
        self.searchCompleter.delegate = self

        queryCancellable = $queryFragment
            .receive(on: DispatchQueue.main)
            // we're debouncing the search, because the search completer is rate limited.
            // feel free to play with the proper value here
            .debounce(for: .milliseconds(250), scheduler: RunLoop.main, options: nil)
            .sink(receiveValue: { fragment in
                self.status = .isSearching
                if !fragment.isEmpty {
                    self.searchCompleter.queryFragment = fragment
                } else {
                    self.status = .idle
                    self.searchResults = []
                }
        })
    }
}

extension LocationService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // Depending on what you're searching, you might need to filter differently or
        // remove the filter altogether. Filtering for an empty Subtitle seems to filter
        // out a lot of places and only shows cities and countries.
        //self.searchResults = completer.results.filter({ $0.subtitle == "" })
        self.searchResults = completer.results
        print(self.searchResults)
        self.status = completer.results.isEmpty ? .noResults : .result
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.status = .error(error.localizedDescription)
    }
}

