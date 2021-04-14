//
//  BlueGoldenHourViewModel.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 27/11/20.
//

import Foundation
import Combine
import MapKit
import CoreLocation

class SunHoursViewModel: NSObject, ObservableObject {
  
    @Published var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    @Published var userLocality: String = ""
    @Published var userRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
  
    private let locationManager = CLLocationManager()
    let dateFormatter = DateFormatter(dateFormat: "HH:mm")
    @Published var solar = Solar(coordinate: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))
    @Published var sunHours = [Solar](repeating: Solar(coordinate: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))!, count: 7)
    @Published var isLoading = false

    
  
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.dateFormatter.timeZone = .current
        // self.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
    }
    
    func changeLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func updateLocation(search: MKLocalSearchCompletion) {
        self.isLoading = true
        self.locationManager.stopUpdatingLocation()
        let request = MKLocalSearch.Request(completion: search)
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            self.userLocation = response.mapItems[0].placemark.coordinate
            self.userLocality = response.mapItems[0].placemark.locality!
            self.calculateSunHours()
            
        }
        self.isLoading = false
    }
    
    func resetLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func calculateSunHours() {
        print("Calculating")
        self.solar = Solar(coordinate: userLocation)
        self.sunHours[0] = solar!
        for i in 0...6 {
            self.solar = Solar(for: Date().addDays(days: i), coordinate: userLocation)
            self.sunHours[i] = solar!
        }
    }
}

extension SunHoursViewModel: CLLocationManagerDelegate {
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location.coordinate
        solar = Solar(coordinate: userLocation)
        sunHours[0] = solar!
        for i in 0...6 {
            solar = Solar(for: Date().addDays(days: i), coordinate: userLocation)
            sunHours[i] = solar!
        }
        print(location)
        userRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                (placemarks, error) in
                if error == nil {
                    guard let placeMark = placemarks?.first else { return }
                    // Street address
                    if let locality = placeMark.locality {
                        self.userLocality = locality
                    }
                } else {
                    print(error?.localizedDescription)
                }

        })
    }
}

