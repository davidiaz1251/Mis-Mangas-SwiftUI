//
//  FilterBasicView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 16/2/25.
//

import SwiftUI

struct FilterBasicView: View {
    @Environment(MangasVM.self) private var vm: MangasVM

    var body: some View {
        List {
            Section("Explorar por") {
                navigationItem(title: "Todos", icon: "list.bullet", category: .mangas)
                navigationItem(title: "Géneros", icon: "books.vertical", category: .genres)
                navigationItem(title: "Autores", icon: "person.text.rectangle", category: .authors)
                navigationItem(title: "Demográficos", icon: "person.2", category: .demographics)
                navigationItem(title: "Temáticas", icon: "text.book.closed", category: .themes)
                navigationItem(title: "Mejores mangas", icon: "star.circle", category: .bestMangas)
            }
        }
    }

    private func navigationItem(title: String, icon: String, category: APIListEndpoint) -> some View {
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


#Preview {
    NavigationStack {
        FilterBasicView()
            .environment(MangasVM(network: NetworkTest()))
    }
}
