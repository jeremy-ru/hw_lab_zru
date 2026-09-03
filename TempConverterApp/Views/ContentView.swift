//
//  ContentView.swift
//  TempConverterApp
//
//  Created by Jeremy Ru on 2026/9/3.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewController = ViewController()
    @State var inputTemp: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Color - KEEPING BLUE
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.80)
                
                VStack {
                    Spacer()
                    
                    // Converted Temperature Display - Changed to black
                    if viewController.isConvertingCtoF {
                        Text("\(viewController.convertedTempString) °F")
                            .font(.largeTitle)
                            .fontWeight(.ultraLight)
                            .foregroundColor(.black)
                    } else {
                        Text("\(viewController.convertedTempString) °C")
                            .font(.largeTitle)
                            .fontWeight(.ultraLight)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    // Label - Changed to black
                    Text("Enter Temperature:")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    // Input Field - Changed border to black, text to black
                    HStack {
                        TextField("temperature", text: $inputTemp)
                            .padding(.horizontal)
                            .frame(width: 200.0, height: 35.0)
                            .border(Color.black, width: 0.50)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numbersAndPunctuation)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    // MARK: - Toggle with labels on both sides (spaced further apart)
                    HStack {
                        Text("°F -> °C")
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                        
                        Spacer()
                            .frame(width: 30)  // Added space
                        
                        Toggle("", isOn: $viewController.isConvertingCtoF)
                            .toggleStyle(SwitchToggleStyle(tint: .white))
                            .frame(width: 50)
                        
                        Spacer()
                            .frame(width: 30)  // Added space
                        
                        Text("°C -> °F")
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    
                    // Convert Button - Changed to black text
                    Button("Convert") {
                        viewController.setInputTempString(self.inputTemp)
                        viewController.convert()
                    }
                    .padding(.all)
                    .background(Color.white)
                    .cornerRadius(15.0)
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Navigation Link to Info Page
                    NavigationLink(destination: InfoView()) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
