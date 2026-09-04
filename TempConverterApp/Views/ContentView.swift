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
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.80)
                
                VStack {
                    Spacer()
                    
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
                    
                    Text("Enter Temperature:")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
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
                    
                    // MARK: - Toggle with labels on both sides
                    HStack {
                        Text("°F -> °C")
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                        
                        Spacer()
                            .frame(width: 30)
                        
                        Toggle("", isOn: $viewController.isConvertingCtoF)
                            .toggleStyle(SwitchToggleStyle(tint: .white))
                            .frame(width: 50)
                        
                        Spacer()
                            .frame(width: 30)
                        
                        Text("°C -> °F")
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    
                    // Convert Button
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
