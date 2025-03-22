//
//  mangasDB.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 3/3/25.
//

import Foundation
import SwiftData

@Model
final class MangasDB: Hashable{
    @Attribute(.unique) var id: Int
    var title: String
    var url: String
    var currentChapters: Int
    var volumesPurchased: Int
    var totalVolumes: Int
    var isCompleteCollection: Bool
    
    init(id: Int, title: String, url: URL, currentChapters: Int, volumesPurchased: Int, totalVolumes: Int, compvareCollection: Bool) {
        self.id = id
        self.title = title
        self.url = url.absoluteString
        self.currentChapters = currentChapters
        self.volumesPurchased = volumesPurchased
        self.totalVolumes = totalVolumes
        self.isCompleteCollection = compvareCollection
    }
}
