//
//  Array.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 1/3/25.
//

import SwiftUI

extension Array where Element == Manga {
    func filteredBy(minRating: Double) -> [Manga] {
        var filtered = self
        if minRating > 0 {
            filtered = filtered.filter { $0.score >= minRating }
        }
        return filtered
    }
}
