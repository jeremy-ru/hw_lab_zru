//
//  EditPersonView.swift
//  SimpleContacts
//
//  Created by Jeremy Ru on 2026/10/7.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person: Person                    // Two-way binding to a reference type
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        Form {
            Section("Photo") {
                // Show the stored image if we have one
                if let imageData = person.photo,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }

            Section("Information") {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                TextField("Email", text: $person.email)
                    .textContentType(.emailAddress)
            }

            Section("Details") {
                TextField("Details", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        // New two-parameter onChange (iOS 17+)
        .onChange(of: selectedItem) { _, _ in
            loadPhoto()
        }
    }

    // Loads the picked image into person.photo as raw Data
    func loadPhoto() {
        Task { @MainActor in
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}
