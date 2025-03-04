//
//  Network.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 4/1/25.
//

import Foundation

protocol DataRepository: Sendable{
    func getMangasBy(prePath: PrePath, by: APIListEndpoint, page: String, per: String) async throws -> [Manga]
    func getMangasBySearch(prePath: PrePath, by: APIListEndpoint) async throws -> [Manga]
    func getMangaById(prePath: PrePath, by: APIListEndpoint) async throws -> Manga?
    func getListBy(by: APIListEndpoint) async throws -> [String]
    func getListAuthor(by: APIListEndpoint) async throws -> [String]
    func getMangasCustom(prePath: PrePath, by: APIListEndpoint, body: CustomSearch) async throws -> [Manga]
    func getCharacters(id: String) async throws -> [CharacterModel]
}

struct Network: DataRepository, NetworkInteractor{
    
    func getMangasBy(prePath: PrePath, by: APIListEndpoint, page: String = "1", per: String = "10") async throws -> [Manga]{
        try await getJson(request: .get(.getListMangas(prePath: prePath, endPoint: by, page: page, per: per)), type: Response.self).items.compactMap{ $0.toManga }
    }
    
    func getMangasBySearch(prePath: PrePath, by: APIListEndpoint) async throws -> [Manga]{
        try await getJson(request: .get(.getListMangas(prePath: prePath, endPoint: by)), type: [MisMangaDTO].self).compactMap{ $0.toManga }
    }
    
    func getMangaById(prePath: PrePath, by: APIListEndpoint) async throws -> Manga?{
        try await getJson(request: .get(.getListMangas(prePath: prePath, endPoint: by)), type: MisMangaDTO.self).toManga
    }
    
    func getMangasCustom(prePath: PrePath, by: APIListEndpoint, body: CustomSearch) async throws -> [Manga]{
        try await getJson(request: .post(url: .getListMangas(prePath: prePath, endPoint: by), body: body), type: Response.self).items.compactMap{ $0.toManga }
    }
    
    func getListBy(by: APIListEndpoint) async throws -> [String]{
        try await getJson(request: .get(.getListMangas(endPoint: by)), type: [String].self)
    }
    
    func getListAuthor(by: APIListEndpoint) async throws -> [String]{
        try await getJson(request: .get(.getListMangas(endPoint: by)), type: [Author].self).compactMap{
            $0.toString
        }
    }
    
    func getCharacters(id: String) async throws -> [CharacterModel]{
        try await getJson(request: .get(.getCharacterImages(id: id)), type: CharacterDTO.self).data.compactMap{ $0.toCharacter }
    }
}
