//
//  CarCoordinateTests.swift
//  FindMyCar
//
//  Created by Jeremy Ru on 2026/10/28.
//

import Testing
import Foundation
@testable import FindMyCar

struct CarCoordinateTests {
    
    // Tests that the default initializer sets values to zero
    @Test func defaultInitializerIsZero() {
        let coord = CarCoordinate()
        #expect(coord.latitude == 0.0)
        #expect(coord.longitude == 0.0)
    }
    
    // Tests that the custom initializer stores the correct values
    @Test func customInitializerStoresValues() {
        let coord = CarCoordinate(latitude: 40.7128, longitude: -74.0060)
        #expect(coord.latitude == 40.7128)
        #expect(coord.longitude == -74.0060)
    }
    
    // Tests that equality works correctly for CarCoordinate
    @Test func equalityWorks() {
        let a = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let b = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let c = CarCoordinate(latitude: 0, longitude: 0)
        
        #expect(a == b)
        #expect(a != c)
    }
    
    // Tests that the coordinate can be encoded to and decoded from a plist
    @Test func encodesAndDecodesRoundTrip() throws {
        let original = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let data = try PropertyListEncoder().encode(original)
        let decoded = try PropertyListDecoder().decode(CarCoordinate.self, from: data)
        
        #expect(decoded == original)
    }
}
