//
//  PathAPI.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 25/1/25.
//

import Foundation

enum PrePath: String{
    case list = "list"
    case search = "search"
}

enum APIListEndpoint: Hashable {
    case mangas
    case manga
    case bestMangas
    case authors
    case demographics
    case genres
    case themes
    case mangaByGenre(String)
    case mangaByDemographic(String)
    case mangaByTheme(String)
    case mangaByAuthor(String)
    case mangasBeginsWith(String)
    case mangasContains(String)
    case mangaId(String)
    
    var path: String {
        switch self {
        case .mangas:
            "mangas"
        case .manga:
            "manga"
        case .bestMangas:
            "bestMangas"
        case .authors:
            "authors"
        case .demographics:
            "demographics"
        case .genres:
            "genres"
        case .themes:
            "themes"
        case .mangaByGenre(let genre):
            "mangaByGenre/\(genre)"
        case .mangaByDemographic(let demographic):
            "mangaByDemographic/\(demographic)"
        case .mangaByTheme(let theme):
            "mangaByTheme/\(theme)"
        case .mangaByAuthor(let authorID):
            "mangaByAuthor/\(authorID)"
        case .mangasBeginsWith(let begins):
            "mangasBeginsWith/\(begins)"
        case .mangasContains(let contains):
            "mangasContains/\(contains)"
        case .mangaId(let id):
            "manga/\(id)"
        }
    }
}
