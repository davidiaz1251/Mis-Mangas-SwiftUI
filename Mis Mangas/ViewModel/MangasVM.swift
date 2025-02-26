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
    var listCategory: [String] = []
    
    var showAlert = false
    var errorMsg = ""
    
    var selectedGenre: GenreModel = .all
    var selectedStatus: MangaStatus = .all
    var selectedTheme: ThemeModel = .all
    var selectedDemographic: DemographicModel = .all
    var selectedSearchBy: SearchBy = .title
    var minRating: Double = 0
    var searchText = ""
    
    var loading = false
    
    var page = 1
    var per = 24
    var currentBy: APIListEndpoint?
    
    private var searchTimer: Timer?
    
    
    init(network: DataRepository = Network()) {
        self.network = network
        Task{
            await self.getMangaBy(by: .bestMangas)
        }
    }
    
    func getMangaBy(prePath: PrePath = .list,
                    by: APIListEndpoint,
                    fetcher: ((PrePath, APIListEndpoint) async throws -> [Manga])? = nil) async {
        
        if currentBy?.path != by.path {
            currentBy = by
        }
        self.page = 1
        self.mangas = []
        self.loading = true
        
        defer {
            self.loading = false
        }
        
        do {
            let mangasBy: [Manga]
            
            if let fetcher = fetcher {
                mangasBy = try await fetcher(prePath, by)
            } else {
                mangasBy = try await network.getMangasBy(
                    prePath: prePath,
                    by: by,
                    page: "\(self.page)",
                    per: "\(self.per)"
                )
            }
            
            self.mangas = filterLocal(mangas: mangasBy)
        } catch {
            self.errorMsg = error.localizedDescription
            self.mangas = []
            showAlert.toggle()
        }
    }
    
    func loadMoreMangas(prePath: PrePath = .list, by: APIListEndpoint) async{
        do{
            self.page += 1
            let mangasBy = try await network.getMangasBy(prePath: prePath, by: by, page: String(self.page), per: String(self.per))
            self.mangas += mangasBy
            print(mangas.count)
        }catch{
            print("Page", self.page)
            self.errorMsg = error.localizedDescription
            showAlert.toggle()
        }
        
    }
    
    func loadListCategory(endpoint: APIListEndpoint) async {
        self.loading = true
        self.listCategory = []
        defer { self.loading = false }
        
        do {
            switch endpoint {
            case .authors:
                self.listCategory = try await network.getListAuthor(by: endpoint)
            default:
                self.listCategory = try await network.getListBy(by: endpoint)
            }
        } catch {
            print("Error al cargar la lista para \(endpoint): \(error)")
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
    
    private func searchMangas() {
        // Aquí implementas la lógica de búsqueda de manera asincrónica
        print("Buscando mangas con \(searchText)")
        print("\(selectedGenre)")
        print("\(selectedTheme)")
        print("\(selectedDemographic)")
        print("\(selectedStatus)")
        print("\(minRating)")
        print("\(selectedSearchBy)")
        var prePath: PrePath = .list
        var endPoint: APIListEndpoint
        switch selectedSearchBy {
        case .contains:
            prePath = .search
            endPoint = .mangasContains(searchText)
        case .beginsWith:
            prePath = .search
            endPoint = .mangasBeginsWith(searchText)
        case .idManga:
            prePath = .search
            endPoint = .mangaId(searchText)
        default:
            endPoint = .mangas
        }
        print(prePath, endPoint)
        Task{
            await getMangaBy(prePath: prePath, by: endPoint, fetcher: network.getMangasBy(prePath:by:))
            print(mangas.count)
        }
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
    
    func filterLocal(mangas: [Manga])-> [Manga]{
        var filterMangas = mangas
        if selectedStatus == .all && minRating == 0 {
            return filterMangas
        }
        if selectedStatus != .all {
            filterMangas = filterMangas.filter{ $0.status == selectedStatus.rawValue}
        }
        if minRating > 0 {
            filterMangas = filterMangas.filter{ $0.score >= minRating}
        }
        return filterMangas
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

