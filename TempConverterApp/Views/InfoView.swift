//
//  InfoView.swift
//  TempConverterApp
//
//  Created by Jeremy Ru on 2026/9/3.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.all)
                .opacity(0.80)
            
            VStack {
                Spacer()
                
                Text("About TempConverter")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                Text("""
                    This is the ever-famous TempConverter 
                    turned into a working iOS app. 
                    
                    This is a moment of great celebration! 
                    People of the Earth, rejoice!
                    """)
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Info")
    }
}

#Preview {
    InfoView()
}
