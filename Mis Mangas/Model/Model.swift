//
//  Model.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 21/12/24.
//

import Foundation

struct Manga: Identifiable, Hashable , Codable {
    let id: Int
    let title: String
    let titleEnglish: String?
    let titleJapanese: String
    let url: URL?
    let startDate: Date?
    let endDate: Date?
    let chapters: Int?
    let volumes: Int?
    let score: Double
    let status: String
    let mainPicture: URL?
    let sypnosis: String
    let background: String?
    let themes: [ThemeModel]
    let authors: [AuthorModel]
    let genres: [GenreModel]
    let demographics: [DemographicModel]
}

enum ThemeModel: String, CaseIterable, Codable, Identifiable {
    case gore = "Gore"
    case military = "Military"
    case mythology = "Mythology"
    case psychological = "Psychological"
    case historical = "Historical"
    case samurai = "Samurai"
    case romanticSubtext = "Romantic Subtext"
    case school = "School"
    case adultCast = "Adult Cast"
    case parody = "Parody"
    case superPower = "Super Power"
    case teamSports = "Team Sports"
    case delinquents = "Delinquents"
    case workplace = "Workplace"
    case survival = "Survival"
    case childcare = "Childcare"
    case iyashikei = "Iyashikei"
    case reincarnation = "Reincarnation"
    case showbiz = "Showbiz"
    case anthropomorphic = "Anthropomorphic"
    case lovePolygon = "Love Polygon"
    case music = "Music"
    case mecha = "Mecha"
    case combatSports = "Combat Sports"
    case isekai = "Isekai"
    case gagHumor = "Gag Humor"
    case crossdressing = "Crossdressing"
    case reverseHarem = "Reverse Harem"
    case martialArts = "Martial Arts"
    case visualArts = "Visual Arts"
    case harem = "Harem"
    case otakuCulture = "Otaku Culture"
    case timeTravel = "Time Travel"
    case videoGame = "Video Game"
    case strategyGame = "Strategy Game"
    case vampire = "Vampire"
    case mahouShoujo = "Mahou Shoujo"
    case highStakesGame = "High Stakes Game"
    case cgdct = "CGDCT"
    case organizedCrime = "Organized Crime"
    case detective = "Detective"
    case performingArts = "Performing Arts"
    case medical = "Medical"
    case space = "Space"
    case memoir = "Memoir"
    case villainess = "Villainess"
    case racing = "Racing"
    case pets = "Pets"
    case magicalSexShift = "Magical Sex Shift"
    case educational = "Educational"
    case idolsFemale = "Idols (Female)"
    case idolsMale = "Idols (Male)"
    case all = "All"
    
    var id: Self { self }
}

enum GenreModel: String, CaseIterable, Codable, Identifiable{
    case action = "Action"
    case adventure = "Adventure"
    case awardWinning = "Award Winning"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case supernatural = "Supernatural"
    case mystery = "Mystery"
    case sliceOfLife = "Slice of Life"
    case comedy = "Comedy"
    case sciFi = "Sci-Fi"
    case suspense = "Suspense"
    case sports = "Sports"
    case ecchi = "Ecchi"
    case romance = "Romance"
    case girlsLove = "Girls Love"
    case boysLove = "Boys Love"
    case gourmet = "Gourmet"
    case erotica = "Erotica"
    case hentai = "Hentai"
    case avantGarde = "Avant Garde"
    case all = "All"
    
    var id: Self { self }
}

enum DemographicModel: String, CaseIterable, Codable, Identifiable {
    case seinen = "Seinen"
    case shounen = "Shounen"
    case shoujo = "Shoujo"
    case josei = "Josei"
    case kids = "Kids"
    case all = "All"
    
    var id: Self { self }
}

enum SearchBy: String, CaseIterable, Codable, Identifiable {
    case title = "Título"
    case firstName = "Nombre del Autor"
    case lastName = "Apellido del Autor"
    case beginsWith = "Empieza con"
    case contains = "Contenga"
    case idManga = "Id manga"
    
    var id: Self { self }
}


struct AuthorModel: Hashable , Codable{
    let lastName: String
    let firstName: String
    let id: UUID
    let role: String
}

extension Manga {
    func formattedGenres(limit: Int = 2) -> String {
        let genresList = genres.prefix(limit).map { $0.rawValue }.joined(separator: ", ")
        return "Géneros: \(genresList)"
    }
    
    static func searchEndpoint(for searchBy: SearchBy, query: String) -> (PrePath, APIListEndpoint) {
        switch searchBy {
        case .contains:
            (.search, .mangasContains(query))
        case .beginsWith:
             (.search, .mangasBeginsWith(query))
        case .idManga:
             (.search, .mangaId(query))
        case .title, .firstName, .lastName:
            (.search, .manga)
        }
    }
}
