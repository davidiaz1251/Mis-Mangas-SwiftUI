//
//  mangasDB.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 3/3/25.
//

import Foundation
import SwiftData

@Model
final class mangasDB{
    var id: String
    var title: String
    var url: URL
    var currentVolume: Int
    var volumesPurchased: Int
    var totalVolumes: Int
    var compvareCollection: Bool
    
    init(id: String, title: String, url: URL, currentVolume: Int, volumesPurchased: Int, totalVolumes: Int, compvareCollection: Bool) {
        self.id = id
        self.title = title
        self.url = url
        self.currentVolume = currentVolume
        self.volumesPurchased = volumesPurchased
        self.totalVolumes = totalVolumes
        self.compvareCollection = compvareCollection
    }
}
