//
//  ListCategoryView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 23/2/25.
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
            "Mangas"
        }
    }
    
    var body: some View {
        LoadingView(content: {
            List(vm.listCategory, id: \.self) { value in
                NavigationLink(value: endpoint(for: value)) {
                    if category == .authors, let match = value.firstMatch(of: /^(.*?)\s*&/){
                        Text(String(match.1))
                    }else{
                        Text(value)
                    }
                }
            }
            .listStyle(.plain)
        }, data: !vm.listCategory.isEmpty, loading: vm.loading)
        .onAppear{
            
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.loadListCategory(endpoint: category)
        }
    }
    
    private func endpoint(for value: String) -> APIListEndpoint {
        switch category {
        case .genres:
            return .mangaByGenre(value)
        case .demographics:
            return .mangaByDemographic(value)
        case .themes:
            return .mangaByTheme(value)
        case .authors:
            if let match = value.firstMatch(of: /(?i)\b(?=[A-Z0-9-]*-[A-Z0-9-]+)[A-Z0-9-]+\b/) {
                return .mangaByAuthor("\(match.0)")
            }
            return .mangaByAuthor("")
        default:
            return category
        }
    }
}

#Preview {
    ListCategoryView(category: .genres)
        .environment(MangasVM(network: NetworkTest()))
}
