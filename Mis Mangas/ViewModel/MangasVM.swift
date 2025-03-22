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
    var characters: [CharacterModel] = []
    
    
    var selectedGenre: [GenreModel] = [.all]
    var selectedTheme: [ThemeModel] = [.all]
    var selectedDemographic: [DemographicModel] = [.all]
    var selectedSearchBy: SearchBy = .title
    var selectContain = false
    var minRating: Double = 0
    var searchText = ""
    
    var loading = false
    
    var page = 1
    var per = 24
    var currentBy: APIListEndpoint?
    
    private var searchTimer: Timer?
    
    
    init(network: DataRepository = Network()) {
        self.network = network
    }
    
    func getMangaBy(prePath: PrePath = .list,
                    by: APIListEndpoint,
                    fetcher: SearchBy? = nil,
                    custom: CustomSearch? = nil) async {
        
        if let current = currentBy{
            if current.path != by.path{
                currentBy = by
            }
        }else{
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
            switch fetcher {
            case .some(.idManga):
                let manga = try await network.getMangaById(prePath: prePath, by: by)
                mangasBy = manga != nil ? [manga!] : []
            case .none, .contains:
                mangasBy = try await network.getMangasBy(
                    prePath: prePath,
                    by: by,
                    page: "\(self.page)",
                    per: "\(self.per)"
                )
            case .firstName, .lastName, .title:
                mangasBy = try await network.getMangasCustom(prePath: prePath, by: by, body: custom!)
            case .some(_):
                mangasBy = try await network.getMangasBySearch(prePath: prePath, by: by)
            }
            
            self.mangas = mangasBy.filteredBy(minRating: minRating)
        } catch {
            self.mangas = []
            print(error.localizedDescription)
        }
    }
    
    func loadMoreMangas(prePath: PrePath = .list, by: APIListEndpoint) async{
        do{
            self.page += 1
            let mangasBy = try await network.getMangasBy(prePath: prePath, by: by, page: String(self.page), per: String(self.per))
            self.mangas += mangasBy
        }catch{
            print(error.localizedDescription)
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
        }
    }
    
    func resetFilters() {
        selectedGenre = [.all]
        selectedTheme = [.all]
        selectedDemographic = [.all]
        selectedSearchBy = .title
        minRating = 0
    }
    
    func dismissSheetFilter(){
        self.searchText = ""
        self.mangas = []
    }
    
    private func searchMangas() {
        let (prePath, endPoint) = Manga.searchEndpoint(for: selectedSearchBy, query: searchText)
        
        let customSearch = CustomSearch(
            searchTitle: !searchText.isEmpty && selectedSearchBy == .title ? searchText : nil,
            searchAuthorFirstName: !searchText.isEmpty && selectedSearchBy == .firstName ? searchText : nil,
            searchAuthorLastName: !searchText.isEmpty && selectedSearchBy == .lastName ? searchText : nil,
            searchGenres: selectedGenre.contains(.all) ? nil : selectedGenre.map { $0.rawValue },
            searchThemes: selectedTheme.contains(.all) ? nil : selectedTheme.map { $0.rawValue },
            searchDemographics: selectedDemographic.contains(.all) ? nil : selectedDemographic.map { $0.rawValue },
            searchContains: selectContain
        )
        Task{
            await getMangaBy(prePath: prePath, by: endPoint, fetcher: selectedSearchBy, custom: customSearch)
        }
    }
    
    func search() {
        searchTimer?.invalidate()
        if searchText.count >= 1 {
            searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                Task {
                    await self?.searchMangas()
                }
            }
        }else{
            self.mangas = []
        }
    }
    
    func getCharacters(id: Int) async {
        self.characters = []
        self.loading = true
        
        defer {
            self.loading = false
        }
        
        do{
            self.characters = try await network.getCharacters(id: "\(id)")
        }catch{
            print(error.localizedDescription)
        }
    }
    
}

