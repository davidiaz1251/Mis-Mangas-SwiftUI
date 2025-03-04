//
//  CharactersView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero on 2/3/25.
//

import SwiftUI

struct CharactersView: View {
    @Environment(MangasVM.self) private var vm: MangasVM
    let id: Int
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        LoadingView(content: {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(vm.characters) { character in
                        VStack {
                            ImageView(url: URL(string: character.imageUrl))
                                .scaledToFit()
                                .frame(height: 150)
                                .overlay {
                                    VStack{
                                        Spacer()
                                        Text(character.name)
                                            .frame(maxWidth: .infinity)
                                            .lineLimit(1)
                                            .background(.ultraThinMaterial)
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding()
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 70)
            }
        }, data: !vm.characters.isEmpty , loading: vm.loading)
        .task {
           await vm.getCharacters(id: id)
        }
    }
}

#Preview {
    CharactersView(id: 42)
        .environment(MangasVM(network: NetworkTest()))
}
