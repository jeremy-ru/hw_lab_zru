//
//  ViewController.swift
//  TempConverterApp
//
//  Created by Jeremy Ru on 2026/9/3.
//

import Foundation
import Combine  // Add this import for ObservableObject

class ViewController: ObservableObject {
    
    // Model instance
    var tempConverter: TempConverter = TempConverter()
    
    // Published properties - these notify the view when changed
    @Published var inputTempString: String = "Temp"
    @Published var convertedTempString: String = "Temp"
    @Published var isConvertingCtoF: Bool = true
    
    // MARK: - Setters
    
    func setInputTempString(_ input: String) {
        self.inputTempString = input
    }
    
    func setConvertedTempString() {
        if let convertedTemp = tempConverter.getConvertedTemp() {
            convertedTempString = String(convertedTemp)
        } else {
            convertedTempString = "N/A"
        }
    }
    
    func setInputTempUnit() {
        if isConvertingCtoF {
            // Fix: Add the argument label 'tempunit:'
            tempConverter.setInputUnit(tempunit: .celsius)
        } else {
            // Fix: Add the argument label 'tempunit:'
            tempConverter.setInputUnit(tempunit: .fahrenheit)
        }
    }
    
    // MARK: - Main Conversion Method
    func convert() {
        // 1. Convert input string to Int (use -500 if invalid)
        let inputTemp = Int(inputTempString) ?? -500
        
        // 2. Set the input temperature units
        setInputTempUnit()
        
        // 3. Set input temperature in the model
        tempConverter.setInputTemp(inputTemp)
        
        // 4. Perform the conversion
        tempConverter.convert()
        
        // 5. Update the displayed converted temperature
        setConvertedTempString()
    }
}
