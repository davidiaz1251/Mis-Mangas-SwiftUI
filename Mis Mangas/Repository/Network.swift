//
//  Network.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 4/1/25.
//

import Foundation

protocol DataRepository: Sendable{
    func getMangasBy(prePath: PrePath, by: APIListEndpoint, page: String, per: String) async throws -> [Manga]
    func getMangasBy(prePath: PrePath, by: APIListEndpoint) async throws -> [Manga]
    func getListBy(by: APIListEndpoint) async throws -> [String]
    func getListAuthor(by: APIListEndpoint) async throws -> [String]
}

struct Network: DataRepository, NetworkInteractor{
    
    func getMangasBy(prePath: PrePath, by: APIListEndpoint, page: String = "1", per: String = "10") async throws -> [Manga]{
        return try await getJson(request: .get(.getListMangas(prePath: prePath, endPoint: by, page: page, per: per)), type: Response.self).items.compactMap{ $0.toManga }
    }
    
    func getMangasBy(prePath: PrePath, by: APIListEndpoint) async throws -> [Manga]{
        return try await getJson(request: .get(.getListMangas(prePath: prePath, endPoint: by, page: "1", per: "10")), type: [MisMangaDTO].self).compactMap{ $0.toManga }
    }
    
    func getListBy(by: APIListEndpoint) async throws -> [String]{
        return try await getJson(request: .get(.getListMangas(endPoint: by, page: "1", per: "10")), type: [String].self)
    }
    
    func getListAuthor(by: APIListEndpoint) async throws -> [String]{
        return try await getJson(request: .get(.getListMangas(endPoint: by, page: "1", per: "10")), type: [Author].self).compactMap{
            $0.toString
        }
    }
}
