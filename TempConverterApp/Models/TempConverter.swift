//
//  TempConverter.swift
//  TempConverterApp
//
//  Created by Jeremy Ru on 2026/9/3.
//

import Foundation

class TempConverter {
    
    // MARK: - Enums
    enum TemperatureUnit: String {
        case fahrenheit = "°F"
        case celsius = "°C"
    }
    
    // MARK: - Properties
    var isConvertingCtoF: Bool = true
    var inputTemp: Int = 0
    var convertedTemp: Int?
    
    // MARK: - Unit Setting
    func setInputUnit(tempunit: TemperatureUnit) {
        switch tempunit {
        case .celsius:
            isConvertingCtoF = true
        case .fahrenheit:
            isConvertingCtoF = false
        }
    }
    
    // MARK: - Temperature Validation
    func isBelowAbsoluteZero() -> Bool {
        if isConvertingCtoF {
            // Converting C to F - absolute zero in Celsius is -273.15
            return inputTemp > -273
        } else {
            // Converting F to C - absolute zero in Fahrenheit is -459.67
            return inputTemp > -460
        }
    }
    
    // MARK: - Conversion Functions
    private func celsiusToFahrenheit() {
        // °F = (°C × 9/5) + 32
        convertedTemp = (inputTemp * 9 / 5) + 32
    }
    
    private func fahrenheitToCelsius() {
        // °C = (°F - 32) × 5/9
        convertedTemp = (inputTemp - 32) * 5 / 9
    }
    
    // MARK: - Main Convert Function
    func convert() {
        guard isBelowAbsoluteZero() else {
            convertedTemp = nil
            return
        }
        
        if isConvertingCtoF {
            celsiusToFahrenheit()
        } else {
            fahrenheitToCelsius()
        }
    }
    
    // MARK: - Setters and Getters
    func setInputTemp(_ temp: Int) {
        inputTemp = temp
    }
    
    func getConvertedTemp() -> Int? {
        return convertedTemp
    }
}
