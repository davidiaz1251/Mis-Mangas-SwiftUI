//
//  MangaSavedRow.swift
//  Mis Mangas
//
//  Created by Alex Guerrero on 16/3/25.
//


import SwiftUI
import SwiftData

struct MangaSavedRow: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var manga: MangasDB
    
    var body: some View {
        HStack {
            ImageView(url: URL(string: manga.url))
                .scaledToFill()
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(manga.title)
                    .font(.title)
                    .lineLimit(1)
                
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
    
    func savedData(){
        do{
            try modelContext.save()
        }catch{
            print("Error al guardar en SwiftData: \(error)")
        }
    }
    
}
