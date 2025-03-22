//
//  DetailMangaView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 26/1/25.
//

import SwiftUI
import SwiftData

struct DetailMangaView: View {
    @State var manga: Manga
    @State private var favorite = false
    @State private var tab: Tabs = .resumen
    @State private var showSheet = false
    @State private var showConfirmation = false
    @Environment(\.modelContext) private var modelContext
    @Query private var mangasFavorite: [MangasDB]
    
    private var visibility : Visibility {
        UIDevice.current.userInterfaceIdiom == .pad ? .visible : .hidden
    }
    
    init(manga: Manga) {
        self.manga = manga
        _mangasFavorite = Query(filter: #Predicate<MangasDB> { $0.id == manga.id })
    }
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                ImageView(url: manga.mainPicture)
                    .scaledToFill()
                    .frame(height: 360)
                    .blur(radius: 10)
                    .overlay {
                        Color.black.opacity(0.3)
                    }
                    .clipped()
                VStack(alignment: .leading){
                    HStack(spacing: 16){
                        ImageView(url: manga.mainPicture)
                            .scaledToFit()
                            .frame(height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack(alignment: .leading){
                            Text(manga.sypnosis)
                                .lineLimit(6)
                            Spacer()
                            Text("Boys Love")
                                .padding(5)
                                .border(.white, width: 2)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .frame(maxHeight: 160)
                        .foregroundStyle(.white)
                        .bold()
                    }
                    Text(manga.title)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .bold()
                }
                .padding(.horizontal)
                .padding(.top, safeAreaTop)
            }
            .confirmationDialog("¿Eliminar manga?", isPresented: $showConfirmation, titleVisibility: visibility) {
                Button("Eliminar", role: .destructive) {
                    if let mangaToDelete = mangasFavorite.first {
                        modelContext.delete(mangaToDelete)
                        do{
                            try modelContext.save()
                            favorite = false
                        }catch{
                            print("Error al guardar en SwiftData: \(error)")
                        }
                    }
                }
                Button("Cancelar", role: .cancel) {
                    showConfirmation = false
                }
            }
            
            Picker("Tabs", selection: $tab) {
                ForEach(Tabs.allCases, id: \.self) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            
            
            switch tab{
            case .resumen:
                SummaryView(manga: manga)
            case .personajes:
                CharactersView(id: manga.id)
                    .frame(maxHeight: .infinity)
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button{
                    if favorite {
                        showConfirmation.toggle()
                    } else {
                        showSheet.toggle()
                    }
                }label:{
                    Image(systemName: "heart")
                        .foregroundStyle(.white)
                        .symbolVariant(favorite ? .fill : .none)
                        .padding(.trailing)
                }
                
            }
        }
        .sheet(isPresented: $showSheet) {
            FavoriteSheetView(manga: manga, favorite: $favorite)
        }
        .onAppear{
            self.favorite = !mangasFavorite.isEmpty
        }
    }
}

extension DetailMangaView{
    private var safeAreaTop: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.windows.first?.safeAreaInsets.top }
            .first ?? 0
    }
}

enum Tabs: String, CaseIterable {
    case resumen = "Resumen"
    case personajes = "Personajes"
}


#Preview(traits: .sampleData) {
    NavigationStack{
        DetailMangaView(manga: NetworkTest.preview)
    }
}
