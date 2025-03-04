//
//  URL.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 3/1/25.
//

import Foundation

let api = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!
let apiCharacterImages = URL(string: "https://api.jikan.moe/v4/manga")!

/// # in case you need for different environments #
//#if DEBUG
//let api = URL(string: "http://localhost:8080")!
//#else
//let api = urlProd
//#endif

extension URL{
    static func getListMangas(prePath: PrePath = .list,endPoint: APIListEndpoint, page: String = "1", per: String = "10") -> URL{
        print(api.appending(path: prePath.rawValue ).appending(path: endPoint.path).appending(queryItems:
                                                                                                [.querys("page", page),
                                                                                                 .querys("per", per)]))
         return api.appending(path: prePath.rawValue ).appending(path: endPoint.path).appending(queryItems:
                                                                                [.querys("page", page),
                                                                                 .querys("per", per)])
    }
    
    static func getCharacterImages(id: String) -> URL{
        print(apiCharacterImages.appending(path: id ).appending(path: "characters"))
        return apiCharacterImages.appending(path: id ).appending(path: "characters")
    }
    
}

extension URLQueryItem{
    static func querys(_ name: String,_ query: String) -> URLQueryItem{
        URLQueryItem(name: name, value: query)
    }
}


