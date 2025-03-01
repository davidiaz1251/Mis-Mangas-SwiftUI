//
//  DataPreview.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 8/1/25.
//

import Foundation


struct NetworkTest: DataRepository{
    
    func getMangasBy(prePath: PrePath = .list,by: APIListEndpoint, page: String = "1", per: String = "10") async throws -> [Manga]{
        try getJson(url: Bundle.main.url(forResource: "mangasPreview", withExtension: "json")!, type: Response.self).items.compactMap{ $0.toManga }
    }
    
    func getMangasBySearch(prePath: PrePath = .list,by: APIListEndpoint) async throws -> [Manga]{
        try getJson(url: Bundle.main.url(forResource: "mangasPreview", withExtension: "json")!, type: [MisMangaDTO].self).compactMap{ $0.toManga }
    }
    
    func getMangaById(prePath: PrePath = .list,by: APIListEndpoint) async throws -> Manga?{
        try getJson(url: Bundle.main.url(forResource: "mangasPreview", withExtension: "json")!, type: MisMangaDTO.self).toManga
    }
    
    func getMangasCustom(prePath: PrePath, by: APIListEndpoint, body: CustomSearch) async throws -> [Manga]{
        try getJson(url: Bundle.main.url(forResource: "mangasPreview", withExtension: "json")!, type: [MisMangaDTO].self).compactMap{ $0.toManga }
    }
    
    func getListBy(by: APIListEndpoint) async throws -> [String]{
        try getJson(url: Bundle.main.url(forResource: "mangasPreview", withExtension: "json")!, type: [String].self)
    }
    
    func getListAuthor(by: APIListEndpoint) async throws -> [String]{
        try getJson(url: Bundle.main.url(forResource: "mangasPreview", withExtension: "json")!, type: [Author].self).compactMap{
            $0.toString
        }
    }
    
    func getJson<JSON>(url: URL, type: JSON.Type) throws -> JSON where JSON: Decodable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let data = try Data(contentsOf: url)
        return try decoder.decode(type, from: data)
    }
    
}
extension NetworkTest{
    static var preview: Manga{
        Manga(
            id: 104,
            title: "Yotsuba to!",
            titleEnglish: "Yotsuba&!",
            titleJapanese: "よつばと!",
            url: URL(string: "https://myanimelist.net/manga/104/Yotsuba_to"),
            startDate: ISO8601DateFormatter().date(from: "2003-03-21T00:00:00Z")!,
            endDate: nil,
            chapters: nil,
            volumes: nil,
            score: 8.88,
            status: "currently_publishing",
            mainPicture: URL(string: "https://cdn.myanimelist.net/images/manga/5/259524l.jpg"),
            sypnosis: """
            While most people find the world mundane, five-year-old Yotsuba Koiwai sees it as a treasure trove ...
            """,
            background: """
            In 2006, Yotsuba to! received an Excellence Award in manga category at Japan Media Arts Festival ...
            """,
            themes: [
                .childcare,
                .iyashikei
            ],
            authors: [
                AuthorModel(
                    lastName: "Azuma",
                    firstName: "Kiyohiko",
                    id: UUID(uuidString: "1907E1C8-560E-4FEF-9F31-80E507848A9E")!,
                    role: "Story & Art"
                )
            ],
            genres: [
                .awardWinning,
                .comedy,
                .sliceOfLife
            ],
            demographics: []
        )
    }
}
