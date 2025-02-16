//
//  MangasVM.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 4/1/25.
//

import SwiftUI

@Observable @MainActor
final class MangasVM {
    let network: DataRepository
    var mangas: [Manga] = []
    
    var showAlert = false
    var errorMsg = ""
    
    var selectedGenre: GenreModel = .all
    var selectedStatus: MangaStatus = .all
    var selectedTheme: ThemeModel = .all
    var selectedDemographic: DemographicModel = .all
    var selectedSearchBy: SearchBy = .title
    var minRating: Int = 0
    var searchText = ""
    
    private var searchTimer: Timer?
    
    
    init(network: DataRepository = Network()) {
        self.network = network
        Task{
            await self.getBestMangas()
        }
    }
    
    
    
    func getMangaByGenre(genre: GenreModel) async{
        do{
            let mangasByGenre = try await network.getMangasByGenre(genre: genre)
            self.mangas = mangasByGenre
        }catch{
            self.errorMsg = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    func getBestMangas() async{
        do{
            self.mangas = try await network.getBestMangas()
            print("\(self.mangas.count)")
        }catch{
            print(error.localizedDescription)
            self.errorMsg = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    func resetFilters() {
        selectedGenre = .all
        selectedTheme = .all
        selectedDemographic = .all
        selectedStatus = .all
        selectedSearchBy = .title
        minRating = 0
    }
    
    private func searchMangas() async {
        // Aquí implementas la lógica de búsqueda de manera asincrónica
        print("Buscando mangas con \(searchText)")
        print("\(selectedGenre)")
        print("\(selectedTheme)")
        print("\(selectedDemographic)")
        print("\(selectedStatus)")
        print("\(minRating)")
        print("\(selectedSearchBy)")
        // Por ejemplo, podrías hacer una llamada a una API aquí.
    }
    
    func search() {
        searchTimer?.invalidate()
        if searchText.count >= 3 {
            searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                Task {
                    await self?.searchMangas()
                }
            }
        }
    }
    
    /*var filteredMangas: [Manga] {
     allMangas.filter { manga in
     let matchesSearch: Bool
     switch selectedSearchCategory {
     case .title:
     matchesSearch = searchText.isEmpty || manga.title.localizedCaseInsensitiveContains(searchText)
     case .firstName:
     matchesSearch = searchText.isEmpty || manga.authors.contains { $0.firstName.localizedCaseInsensitiveContains(searchText) }
     case .lastName:
     matchesSearch = searchText.isEmpty || manga.authors.contains { $0.lastName.localizedCaseInsensitiveContains(searchText) }
     }
     
     return matchesSearch &&
     manga.genres.contains(selectedGenre) &&
     manga.themes.contains(selectedTheme) &&
     manga.demographics.contains(selectedDemographic) &&
     manga.score >= Double(minRating)
     }
     }*/
}

