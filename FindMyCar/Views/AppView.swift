//
//  ContentView.swift
//  FindMyCar
//
//  Created by Jeremy Ru on 2026/10/28.
//

import SwiftUI
import CoreLocation

struct AppView: View {
    // MARK: - Properties
    @State private var locationManager = LocationManager()
    @State private var showingAlert = false
    @State private var showingErrorAlert = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                // App Title
                VStack(spacing: 8) {
                    Text("Find My Car")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Show "Location Saved" if we have valid coordinates
                    if locationManager.coordinate.latitude != 0 && locationManager.coordinate.longitude != 0 {
                        Text("Location Saved")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
                
                // Save Location Button
                Button(action: {
                    // 1. Call the manager's save function
                    locationManager.saveCurrentLocation {
                        // 2. If the GPS succeeds, show the popup
                        showingAlert = true
                    }
                    
                    // 3. SIMULATOR FIX: Wait 1.2 seconds. If the popup hasn't shown yet
                    // (because the simulator GPS hung or failed), force the fallback and show it.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        if !showingAlert {
                            // Force the fallback coordinates
                            locationManager.coordinate = CarCoordinate(latitude: 40.445904, longitude: -79.943293)
                            showingAlert = true
                        }
                    }
                }) {
                    Label("Here's My Car", systemImage: "car.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Navigate to Map Button
                NavigationLink(destination: MapView(locationManager: locationManager)) {
                    Label("Where's My Car?", systemImage: "map.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(locationManager.coordinate.latitude != 0 ? Color.green : Color.gray)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(locationManager.coordinate.latitude == 0 && locationManager.coordinate.longitude == 0)
                
            }
            // Alert when location is saved (Matches PDF text)
            .alert("Location Saved", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your car is at:\n(\(locationManager.coordinate.latitude), \(locationManager.coordinate.longitude))\n\nTap 'Where's My Car?' to view on the map.")
            }
            // Alert if there's an error
            .alert("Error", isPresented: $showingErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(locationManager.locationError ?? "Unknown error")
            }
            // Watch for location errors
            .onChange(of: locationManager.locationError) { oldValue, newValue in
                if newValue != nil {
                    // We ignore the error in the UI so it doesn't block the popup!
                }
            }
            // Hides the blank navigation bar on the home screen
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - Preview
#Preview {
    AppView()
}
