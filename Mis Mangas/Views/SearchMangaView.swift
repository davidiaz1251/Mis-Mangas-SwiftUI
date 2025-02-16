//
//  SearchMangaView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero Flores on 14/2/25.
//

import SwiftUI

struct SearchMangaView: View {
    @State private var filterType: FilterType = .basic
    
    var body: some View {
        NavigationStack {
                VStack {
                    switch filterType {
                    case .basic:
                        FilterBasicView()
                    case .advance:
                        FilterAdvanceView()
                    }
                }
                .navigationTitle("Buscar")
                .navigationDestination(for: APIListEndpoint.self, destination: { value in
                    SearchListView(category: value)
                })
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Menu {
                            if filterType == .basic {
                                Button("Búsqueda avanzada") {
                                    filterType = .advance
                                }
                            } else {
                                Button("Búsqueda básica") {
                                    filterType = .basic
                                }
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
        }
    }
}

enum FilterType: String, CaseIterable {
    case basic = "Basic"
    case advance = "Advance"
}


#Preview {
    SearchMangaView()
        .environment(MangasVM(network: NetworkTest()))
}
