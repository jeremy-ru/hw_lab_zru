//
//  ViewController.swift
//  TempConverterApp
//
//  Created by Jeremy Ru on 2026/9/3.
//

import Foundation
import Combine

class ViewController: ObservableObject {
    
    var tempConverter: TempConverter = TempConverter()
    
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
            tempConverter.setInputUnit(tempunit: .celsius)
        } else {
            tempConverter.setInputUnit(tempunit: .fahrenheit)
        }
    }
    
    // MARK: - Main Conversion Method
    func convert() {
        let inputTemp = Int(inputTempString) ?? -500
        setInputTempUnit()
        tempConverter.setInputTemp(inputTemp)
        tempConverter.convert()
        setConvertedTempString()
    }
}
