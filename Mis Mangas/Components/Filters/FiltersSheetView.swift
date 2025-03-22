//
//  FiltersView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 14/2/25.
//

import SwiftUI

struct FiltersSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedGenre: GenreModel
    @Binding var selectedTheme: ThemeModel
    @Binding var selectedDemographic: DemographicModel
    @Binding var selectedBy: SearchBy
    @Binding var contain: Bool
    @Binding var minRating: Double
    
    let genres: [GenreModel]
    let themes: [ThemeModel]
    let demographics: [DemographicModel]
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
                    
                    Section {
                        Toggle("Contenga", isOn: $contain)
                    } header: {
                        Text("Contenga")
                    }
                }
                
                Section {
                    Stepper("Puntuación mínima: \(minRating.formatted(withDecimals: 0))", value: $minRating, in: 0...10)
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
