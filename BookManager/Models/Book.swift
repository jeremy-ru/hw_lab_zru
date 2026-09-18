//
//  Book.swift
//  BookManager
//
//  Created by Jeremy Ru on 2026/9/18.
//

import Foundation

struct Book: Identifiable, Comparable {
    var id = UUID()
    var title: String
    var author: String
    var gender: String
    var displayed: Bool
    
    init(title: String, author: String, gender: String, displayed: Bool) {
        self.title = title
        self.author = author
        self.gender = gender
        self.displayed = displayed
    }
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title && lhs.author == rhs.author
    }
    
    static func < (lhs: Book, rhs: Book) -> Bool {
        return lhs.title < rhs.title
    }
}
