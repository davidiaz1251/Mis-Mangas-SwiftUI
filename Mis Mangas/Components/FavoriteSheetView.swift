//
//  FavoriteSheetView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 9/3/25.
//

import SwiftUI
import SwiftData

struct FavoriteSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let manga: Manga
    
    @State private var currentChapters: Int = 1
    @State private var volumesPurchased: Int = 0
    @State private var compvareCollection: Bool = false
    
    @Binding var favorite: Bool
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información del Manga")) {
                    
                    Stepper("Capitulo actual: \(currentChapters)", value: $currentChapters, in: 1...(manga.chapters ?? 99))
                    
                    Stepper("Volúmenes comprados: \(volumesPurchased)", value: $volumesPurchased, in: 0...(manga.volumes ?? 99))
                        .onChange(of: volumesPurchased) { oldValue, newValue in
                            compvareCollection = newValue == manga.volumes ? true : false
                        }
                    
                    Toggle("Colección completa", isOn: $compvareCollection)
                        .onChange(of: compvareCollection) { oldValue, newValue in
                            if newValue {
                                volumesPurchased = manga.volumes ?? 0
                            }
                        }
                }
            }
            .navigationTitle("Nuevo Manga")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar"){
                        addManga()
                    }
                }
            }
        }
    }
    
    private func addManga() {
        
        guard let mainPicture = manga.mainPicture else {return}
        
        let newManga = MangasDB(
            id: manga.id,
            title: manga.title,
            url: mainPicture,
            currentChapters: currentChapters,
            volumesPurchased: volumesPurchased,
            totalVolumes: manga.volumes ?? 0,
            compvareCollection: compvareCollection
        )
        
        modelContext.insert(newManga)
        do {
            try modelContext.save()
            favorite.toggle()
        } catch {
            print("Error al guardar en SwiftData: \(error)")
        }
        dismiss()
    }
}

#Preview {
    @Previewable @State var favorite = false
    FavoriteSheetView(manga: NetworkTest.preview, favorite: $favorite)
}
