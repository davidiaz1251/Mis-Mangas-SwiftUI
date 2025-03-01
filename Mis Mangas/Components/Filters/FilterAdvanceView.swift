//
//  FilterAdvanceView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 16/2/25.
//

import SwiftUI

struct FilterAdvanceView: View {
    @Environment(MangasVM.self) private var vm: MangasVM
    @FocusState private var searchFieldFocused: Bool
    @State private var showFilters = false
    
    let genres: [GenreModel] = GenreModel.allCases
    let themes: [ThemeModel] = ThemeModel.allCases
    let demographics: [DemographicModel] = DemographicModel.allCases
    let status: [MangaStatus] = MangaStatus.allCases
    let searchBy: [SearchBy] = SearchBy.allCases
    
    var body: some View {
        @Bindable var vm = vm
        ScrollView{
            VStack{
                HStack {
                    TextField("Buscar por \(vm.selectedSearchBy.rawValue)", text: $vm.searchText)
                        .textFieldStyle(.roundedBorder)
                        .focused($searchFieldFocused)
                        .onChange(of: vm.searchText) {
                            vm.search()
                        }
                    
                    Button {
                        showFilters.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 8)
                }
                .padding()
                LoadingView(content: {
                    ListMangasView(mangas: vm.mangas)
                        .padding(.horizontal)
                }, data: !vm.mangas.isEmpty, loading: vm.loading)
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    searchFieldFocused = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
        .sheet(isPresented: $showFilters) {
            FiltersSheetView(
                selectedGenre: $vm.selectedGenre,
                selectedTheme: $vm.selectedTheme,
                selectedDemographic: $vm.selectedDemographic,
                selectedStatus: $vm.selectedStatus,
                selectedBy: $vm.selectedSearchBy,
                contain: $vm.selectContain,
                minRating: $vm.minRating,
                genres: genres,
                themes: themes,
                demographics: demographics,
                status: status,
                searchBy: searchBy,
                reset: vm.resetFilters
            )
            .presentationDetents([.large])
        }
        .onAppear{
            //vm.mangas.removeAll()
        }
    }
}

#Preview {
    FilterAdvanceView()
        .environment(MangasVM(network: NetworkTest()))
}
