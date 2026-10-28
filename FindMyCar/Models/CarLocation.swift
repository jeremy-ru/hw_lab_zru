//
//  CarLocation.swift
//  FindMyCar
//
//  Created by Jeremy Ru on 2026/10/28.
//

import CoreLocation

// Helper struct to make the car location identifiable for Map annotations
struct CarLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
}
