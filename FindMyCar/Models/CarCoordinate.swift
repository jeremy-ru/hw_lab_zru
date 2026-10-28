//
//  CarCoordinate.swift
//  FindMyCar
//
//  Created by Jeremy Ru on 2026/10/28.
//

import Foundation

// Codable struct for plist persistence
struct CarCoordinate: Codable, Equatable {
    var latitude: Double
    var longitude: Double
    
    // Initializes the coordinate with default zero values
    init(latitude: Double = 0.0, longitude: Double = 0.0) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
