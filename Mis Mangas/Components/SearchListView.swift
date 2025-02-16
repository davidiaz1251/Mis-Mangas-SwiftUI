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
    var body: some View {
        VStack {
            Text("\(category.path)")
                .font(.title)
            if !vm.mangas.isEmpty{
                ForEach(vm.mangas){manga in
                    Text(manga.title)
                }
            }
        }
        .task {
            await vm.getMangaBy(by: category)
        }
    }
}

#Preview {
    SearchListView(category: .genres)
        .environment(MangasVM(network: NetworkTest()))
}
