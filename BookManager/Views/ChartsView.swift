//
//  ChartsView.swift
//  BookManager
//
//  Created by Jeremy Ru on 2026/9/18.
//

import SwiftUI
import Charts

struct ChartsView: View {
    @EnvironmentObject var library: Library
    
    var body: some View {
        VStack {
            Text("Books by Author Gender")
                .font(.headline)
            
            Chart {
                BarMark(
                    x: .value("Gender", "Male"),
                    y: .value("Count", library.getMaleAuthoredBooks().count)
                )
                BarMark(
                    x: .value("Gender", "Female"),
                    y: .value("Count", library.getFemaleAuthoredBooks().count)
                )
                .foregroundStyle(.pink)
            }
            .frame(height: 250)
            .padding(20)
            
            Text("Books by Popular Authors")
                .font(.headline)
                .padding(.top)

            Chart {
                BarMark(
                    x: .value("Author", "Shakespeare"),
                    y: .value("Count", library.getBooksFor("William Shakespeare").count)
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value("Author", "Tolkien"),
                    y: .value("Count", library.getBooksFor("J.R.R. Tolkien").count)
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value("Author", "Austen"),
                    y: .value("Count", library.getBooksFor("Jane Austen").count)
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value("Author", "Dickens"),
                    y: .value("Count", library.getBooksFor("Charles Dickens").count)
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value("Author", "Bronte"),
                    y: .value("Count", library.getBooksFor("Charlotte Bronte").count)
                )
                .foregroundStyle(.green)
            }
            .frame(height: 250)
            .padding(20)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ChartsView()
        .environmentObject(Library())
}
