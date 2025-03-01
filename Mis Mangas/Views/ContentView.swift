//
//  ContentView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 7/12/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(MangasVM.self) private var vm: MangasVM
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                Section{
                    SavedMangasList()
                } header:{
                    Text("Tus Mangas")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Section{
                    ListMangasView(mangas: vm.mangas)
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle("Best Mangas")
            .navigationDestination(for: Manga.self) { manga in
                DetailMangaView(manga: manga)
            }
        }
    }
}
/*.scrollTargetLayout()
 .scrollTargetBehavior(.viewAligned)*/
#Preview {
    ContentView()
        .environment(MangasVM(network: NetworkTest()))
}
