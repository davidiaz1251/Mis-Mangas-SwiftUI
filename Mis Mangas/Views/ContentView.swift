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
    @Environment(\.modelContext) private var modelContext
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
            }
            .onAppear{
                print("base", mangasSaved)
            }
            .padding()
            .navigationTitle("Best Mangas")
            .navigationDestination(for: Manga.self) { manga in
                DetailMangaView(manga: manga)
            }
        }
    }
}
#Preview {
    ContentView()
        .environment(MangasVM(network: NetworkTest()))
}
