//
//  FilterBasicView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero Flores on 16/2/25.
//

import SwiftUI

struct FilterBasicView: View {
    @Environment(MangasVM.self) private var vm: MangasVM

    var body: some View {
        List {
            Section("Explorar por") {
                navigationItem(title: "Todos", icon: "list.bullet", category: .all)
                navigationItem(title: "Géneros", icon: "books.vertical", category: .genres)
                navigationItem(title: "Autores", icon: "person.text.rectangle", category: .authors)
                navigationItem(title: "Demográficos", icon: "person.2", category: .demographics)
                navigationItem(title: "Temáticas", icon: "text.book.closed", category: .themes)
                navigationItem(title: "Mejores mangas", icon: "star.circle", category: .topMangas)
            }
        }
    }

    private func navigationItem(title: String, icon: String, category: BasicFilterCategory) -> some View {
        NavigationLink(value: category){
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .imageScale(.large)
                Text(title)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 6)
        }
    }
}

enum BasicFilterCategory: String, Hashable {
    case genres, authors, demographics, themes, topMangas, all
}

#Preview {
    NavigationStack {
        FilterBasicView()
            .environment(MangasVM(network: NetworkTest()))
    }
}
