//
//  MangaRow.swift
//  Mis Mangas
//
//  Created by Alex Guerrero on 22/3/25.
//

import SwiftUI

struct MangaRowSaved: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var manga: MangasDB
    
    var body: some View {
        HStack {
            // Imagen del manga
            ImageView(url: URL(string: manga.url))
                .scaledToFill()
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(manga.title)
                    .font(.headline)
                
                Stepper(value: $manga.currentChapters, in: 1...(manga.totalVolumes == 0 ? 99 : manga.totalVolumes)) {
                    Text("Capitulo actual: \(manga.currentChapters)/\(manga.totalVolumes)")
                }
                .onChange(of: manga.currentChapters) {
                    savedData()
                }
                
                Stepper(value: $manga.volumesPurchased, in: 0...manga.totalVolumes) {
                    Text("Volumenes comprados: \(manga.volumesPurchased)")
                }
                .onChange(of: manga.volumesPurchased) { oldValue, newValue in
                    manga.isCompleteCollection = newValue == manga.totalVolumes ? true : false
                    savedData()
                }
                
                Toggle("Colección completa", isOn: $manga.isCompleteCollection)
                    .onChange(of: manga.isCompleteCollection) { oldValue, newValue in
                        if newValue {
                            manga.volumesPurchased = manga.totalVolumes
                        }
                        savedData()
                    }
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
    private func savedData() {
        do {
            try modelContext.save()
        } catch {
            print("Error al guardar: \(error)")
        }
    }
}
