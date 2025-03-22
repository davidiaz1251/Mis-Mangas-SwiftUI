//
//  ContentView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 7/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(MangasVM.self) private var vm: MangasVM
    @Query private var mangasSaved: [MangasDB]
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                if !mangasSaved.isEmpty{
                    Section{
                        SavedMangasList(mangaSaved: mangasSaved)
                            .padding(.bottom)
                    } header:{
                        Text("Tus Mangas")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                LoadingView(content: {
                    Section{
                        ListMangasView(mangas: vm.mangas)
                    }
                }, data: !vm.mangas.isEmpty, loading: vm.loading)
                .task {
                    if vm.currentBy != .bestMangas || vm.mangas.isEmpty{
                        await vm.getMangaBy(by: .bestMangas)
                    }
                }
            }
            .padding()
            .navigationTitle("Best Mangas")
            .navigationDestination(for: Manga.self) { manga in
                DetailMangaView(manga: manga)
            }
            .navigationDestination(for: MangasDB.self) { mangaDB in
                FavoriteView(id: mangaDB.id)
                    .navigationTitle("Favoritos")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
#Preview {
    ContentView()
        .environment(MangasVM(network: NetworkTest()))
}
