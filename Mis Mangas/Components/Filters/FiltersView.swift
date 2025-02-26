//
//  FiltersView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero Flores on 14/2/25.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedGenre: GenreModel
    @Binding var selectedTheme: ThemeModel
    @Binding var selectedDemographic: DemographicModel
    @Binding var selectedStatus: MangaStatus
    @Binding var selectedBy: SearchBy
    @Binding var minRating: Double
    
    let genres: [GenreModel]
    let themes: [ThemeModel]
    let demographics: [DemographicModel]
    let status: [MangaStatus]
    let searchBy: [SearchBy]
    let reset: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    Picker("Selecciona tipo", selection: $selectedBy) {
                        ForEach(searchBy) { by in
                            Text(by.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Buscar por")
                }
                
                
                if selectedBy != SearchBy.beginsWith && selectedBy != SearchBy.contains && selectedBy != SearchBy.idManga{
                    Section {
                        Picker("Selecciona un género", selection: $selectedGenre) {
                            ForEach(genres) { genre in
                                Text(genre.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    } header: {
                        Text("Género")
                    }
                    
                    
                    Section {
                        Picker("Selecciona un tema", selection: $selectedTheme) {
                            ForEach(themes) { theme in
                                Text(theme.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    } header: {
                        Text("Tema")
                    }
                    
                    
                    Section {
                        Picker("Selecciona una demografía", selection: $selectedDemographic) {
                            ForEach(demographics) { demographic in
                                Text(demographic.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    } header: {
                        Text("Demografía")
                    }
                }
                
                Section {
                    Picker("Estado", selection: $selectedStatus) {
                        ForEach(MangaStatus.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Estado")
                }
                
                
                Section {
                    Stepper("Puntuación mínima: \(minRating.formatted(.number.precision(.fractionLength(0))))", value: $minRating, in: 0...10)
                } header: {
                    Text("Puntuación")
                }
                
            }
            .navigationTitle("Filtros")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        reset()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("OK") {
                        dismiss()
                    }
                }
            }
            
        }
    }
}
