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
    
    @State private var currentVolume: Int = 1
    @State private var volumesPurchased: Int = 0
    @State private var compvareCollection: Bool = false
    
    @Binding var favorite: Bool
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información del Manga")) {
                    
                    Stepper("Volumen actual: \(currentVolume)", value: $currentVolume, in: 1...(manga.volumes ?? 99))
                    
                    Stepper("Volúmenes comprados: \(volumesPurchased)", value: $volumesPurchased, in: 0...(manga.volumes ?? 99))
                    
                    Toggle("Colección completa", isOn: $compvareCollection)
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
            currentVolume: currentVolume,
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
