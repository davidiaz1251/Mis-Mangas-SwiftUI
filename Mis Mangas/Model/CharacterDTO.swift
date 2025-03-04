//
//  CharacterDTO.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 2/3/25.
//

import Foundation


struct CharacterDTO: Codable {
    let data: [CharacterData]
}


struct CharacterData: Codable {
    let character: Character
    let role: String
}


struct Character: Codable {
    let malId: Int
    let url: String
    let images: Images
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case url, images, name
    }
}


struct Images: Codable {
    let jpg: ImageDetail
    let webp: ImageDetail
}


struct ImageDetail: Codable {
    let imageUrl: String
    let smallImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case smallImageUrl = "small_image_url"
    }
}

extension CharacterData{
    var toCharacter: CharacterModel {
        CharacterModel(
            name: character.name,
            imageUrl: character.images.jpg.imageUrl,
            url: character.url,
            id: character.malId
        )
    }
}

