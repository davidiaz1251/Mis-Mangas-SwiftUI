//
//  SearchListView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero Flores on 16/2/25.
//

import SwiftUI

struct SearchListView: View {
    @Environment(MangasVM.self) private var vm: MangasVM
    let category: APIListEndpoint
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            
            if vm.loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if !vm.mangas.isEmpty {
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        ForEach(vm.mangas) { manga in
                            NavigationLink(value: manga){
                                VStack {
                                    ImageView(url: manga.mainPicture)
                                        .scaledToFit()
                                        .frame(height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                    .padding()
                    if !vm.allMangasLoaded {
                        Button(action: {
                            Task {
                                await vm.loadMoreMangas(by: category)
                            }
                        }) {
                            Text("Cargar más")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                }
                .navigationDestination(for: Manga.self) { manga in
                    DetailMangaView(manga: manga)
                }
            } else {
                // Si no hay mangas, muestra un mensaje
                Text("No mangas found.")
            }
        }
        .task {
            await vm.getMangaBy(by: category)
        }
        .navigationTitle("titulo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        SearchListView(category: .genres)
            .environment(MangasVM(network: NetworkTest()))
    }
}


