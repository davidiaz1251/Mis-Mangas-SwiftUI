//
//  FavoriteView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero on 22/3/25.
//


//
//  FavoriteView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 11/3/25.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    var id: Int?
    @Environment(\.modelContext) private var modelContext
    @Query private var mangasSaved: [MangasDB]
    
    init(id: Int? = nil) {
        self.id = id
        if let id = id{
            _mangasSaved = Query(filter: #Predicate<MangasDB> { $0.id == id })
        }
    }
    
    var body: some View {
            if mangasSaved.isEmpty{
                VStack(spacing: 16) {
                    Image(systemName: "bookmark.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    
                    Text("No tienes mangas favoritos")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text("Agrega tus mangas favoritos para verlos aquí")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            List{
                ForEach(mangasSaved){ manga in
                    MangaSavedRow(manga: manga)
                        .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let manga = mangasSaved[index]
                        modelContext.delete(manga)
                    }
                    do {
                        try modelContext.save()
                    } catch {
                        print("Error al guardar en SwiftData: \(error)")
                    }
                }
            }
            .listStyle(.plain)
    }
}

#Preview(traits: .sampleData){
    FavoriteView()
}
