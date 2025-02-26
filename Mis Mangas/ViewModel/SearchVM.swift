//
//  SearchVM.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 15/2/25.
//

import Foundation


final class SearchVM{
    let genres: [GenreModel] = GenreModel.allCases
    let themes: [ThemeModel] = ThemeModel.allCases
    let demographics: [DemographicModel] = DemographicModel.allCases
    let status: [MangaStatus] = MangaStatus.allCases
}
