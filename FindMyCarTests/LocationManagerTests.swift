//
//  LocationManagerTests.swift
//  FindMyCar
//
//  Created by Jeremy Ru on 2026/10/28.
//

import Testing
import CoreLocation
@testable import FindMyCar

@MainActor
struct LocationManagerTests {
    
    // Tests that the manager starts with a zero coordinate
    @Test func startsWithZeroCoordinate() {
        let manager = LocationManager(shouldLoad: false)
        #expect(manager.coordinate == CarCoordinate())
    }
    
    // Tests that clearLocation resets the coordinate back to zero
    @Test func clearLocationResetsCoordinate() {
        let manager = LocationManager(shouldLoad: false)
        manager.coordinate = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        manager.clearLocation()
        #expect(manager.coordinate == CarCoordinate())
    }
    
    // Tests that denied authorization produces an error message
    @Test func deniedAuthorizationProducesError() {
        let manager = LocationManager(shouldLoad: false)
        manager.authorizationStatus = .denied
        manager.saveCurrentLocation()
        #expect(manager.locationError != nil)
    }
}
