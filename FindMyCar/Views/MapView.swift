//
//  MapView.swift
//  FindMyCar
//
//  Created by Jeremy Ru on 2026/10/28.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    // MARK: - Properties
    var locationManager: LocationManager
    @State private var position: MapCameraPosition = .automatic
    
    // MARK: - Computed Properties
    // Creates the car coordinate for the map annotation
    private var carCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: locationManager.coordinate.latitude,
            longitude: locationManager.coordinate.longitude
        )
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $position) {
                // Pin for the Car (Matches PDF)
                Annotation("Your Car", coordinate: carCoordinate) {
                    VStack(spacing: 4) {
                        Image(systemName: "car.fill")
                            .font(.title)
                            .foregroundColor(.red)
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                        
                        Text("Your Car")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(4)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(4)
                            .shadow(radius: 2)
                    }
                }
                
                // Pin for the User's current location
                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            
            // The White Box at the top of the map showing coordinates
            VStack(spacing: 4) {
                Text("Your Car Location")
                    .font(.headline)
                Text("Lat: \(locationManager.coordinate.latitude)")
                Text("Lon: \(locationManager.coordinate.longitude)")
            }
            .font(.subheadline)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding(.top, 60) // Pushes it down below the back button
            
        }
        .navigationTitle("Map View")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Center the map on the saved car coordinate
            position = .region(
                MKCoordinateRegion(
                    center: carCoordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                )
            )
        }
    }
}

// MARK: - Preview
#Preview {
    let manager = LocationManager()
    // Set a sample location for preview (CMU coordinates)
    manager.coordinate = CarCoordinate(latitude: 40.445904, longitude: -79.943293)
    return NavigationStack {
        MapView(locationManager: manager)
    }
}
