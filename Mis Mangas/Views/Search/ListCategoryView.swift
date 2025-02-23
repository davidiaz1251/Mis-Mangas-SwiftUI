//
//  ListCategoryView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero on 23/2/25.
//

import SwiftUI

struct ListCategoryView: View {
    @Environment(MangasVM.self) private var vm: MangasVM
    let category: APIListEndpoint
    private var title: String {
        switch category {
        case .genres:
            "Por genero"
        case .demographics:
            "Por demografia"
        case .themes:
            "Por tema"
        case .authors:
            "Por autor"
        default:
            "Por"
        }
    }
    
    var body: some View {
        LoadingView(content: {
            List(vm.listCategory, id: \.self) { value in
                NavigationLink(value: endpoint(for: value)) {
                    Text(value)
                }
            }
            .listStyle(.plain)
        }, data: !vm.listCategory.isEmpty, loading: vm.loading)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.loadListCategory(endpoint: category)
        }
    }
    
    private func endpoint(for value: String) -> APIListEndpoint {
        switch category {
        case .genres:
            .mangaByGenre(value)
        case .demographics:
            .mangaByDemographic(value)
        case .themes:
            .mangaByTheme(value)
        case .authors:
            .mangaByAuthor(value)
        default:
            category
        }
    }
}

#Preview {
    ListCategoryView(category: .genres)
        .environment(MangasVM(network: NetworkTest()))
}
