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
            return "mangas"
        case .bestMangas:
            return "bestMangas"
        case .authors:
            return "authors"
        case .demographics:
            return "demographics"
        case .genres:
            return "genres"
        case .themes:
            return "themes"
        case .mangaByGenre(let genre):
            return "mangaByGenre/\(genre)"
        case .mangaByDemographic(let demographic):
            return "mangaByDemographic/\(demographic)"
        case .mangaByTheme(let theme):
            return "mangaByTheme/\(theme)"
        case .mangaByAuthor(let authorID):
            return "mangaByAuthor/\(authorID)"
        case .mangasBeginsWith(let begins):
            return "mangasBeginsWith/\(begins)"
        case .mangasContains(let contains):
            return "mangasBeginsWith/\(contains)"
        case .mangaId(let id):
            return "mangasBeginsWith/\(id)"
        }
    }
}
