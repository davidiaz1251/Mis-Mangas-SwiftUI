//
//  SearchListView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 16/2/25.
//

import SwiftUI

struct SearchListView: View {
    @Environment(MangasVM.self) private var vm: MangasVM
    let category: APIListEndpoint
    private var title: String {
        switch category {
        case .mangas:
            "Todos"
        case .bestMangas:
            "Por mejores mangas"
        default:
            "Mangas"
        }
    }
    private var gridItems: [GridItem] {
        let columns: Int = UIDevice.current.userInterfaceIdiom == .pad ? 5 : 3
        return Array(repeating: GridItem(.flexible()), count: columns)
    }
    
    var body: some View {
        LoadingView(content: {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(vm.mangas) { manga in
                        NavigationLink(value: manga) {
                            VStack {
                                ImageView(url: manga.mainPicture)
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            VStack{
                                                Text(manga.title)
                                                    .font(.subheadline)
                                                    .lineLimit(1)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .background(.ultraThinMaterial)
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .foregroundStyle(.white)
                                    }
                                
                            }
                        }
                        .onAppear {
                            if manga == vm.mangas.last {
                                Task {
                                    await vm.loadMoreMangas(by: category)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }, data: !vm.mangas.isEmpty , loading: vm.loading)
        .task {
            if vm.currentBy != category || vm.mangas.isEmpty{
                await vm.getMangaBy(by: category)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    NavigationStack{
        SearchListView(category: .genres)
            .environment(MangasVM(network: NetworkTest()))
    }
}


