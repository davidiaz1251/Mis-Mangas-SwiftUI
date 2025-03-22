//
//  FiltersView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 14/2/25.
//

import SwiftUI

struct FiltersSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedGenre: [GenreModel]
    @Binding var selectedTheme: [ThemeModel]
    @Binding var selectedDemographic: [DemographicModel]
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
                                .tag(by)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Buscar por")
                }
                
                if selectedBy != .beginsWith && selectedBy != .contains && selectedBy != .idManga {
                    Section {
                        Menu {
                            ForEach(genres) { genre in
                                Button {
                                    toggleSelection(item: genre, in: &selectedGenre,allValue: .all)
                                } label: {
                                    HStack {
                                        Text(genre.rawValue)
                                        Spacer()
                                        if selectedGenre.contains(genre) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text("Selecciona Géneros")
                                Spacer()
                                Text(selectedGenre.map { $0.rawValue }.joined(separator: ", "))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                    } header:{
                        Text("Géneros")
                    }
                    
                    Section {
                        Menu {
                            ForEach(themes) { theme in
                                Button {
                                    toggleSelection(item: theme, in: &selectedTheme, allValue: .all)
                                } label: {
                                    HStack {
                                        Text(theme.rawValue)
                                        Spacer()
                                        if selectedTheme.contains(theme) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text("Selecciona Temas")
                                Spacer()
                                Text(selectedTheme.map { $0.rawValue }.joined(separator: ", "))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                    } header:{
                        Text("Temas")
                    }
                    
                    Section {
                        Menu {
                            ForEach(demographics) { demographic in
                                Button {
                                    toggleSelection(item: demographic, in: &selectedDemographic, allValue: .all)
                                } label: {
                                    HStack {
                                        Text(demographic.rawValue)
                                        Spacer()
                                        if selectedDemographic.contains(demographic) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text("Selecciona Demografía")
                                Spacer()
                                Text(selectedDemographic.map { $0.rawValue }.joined(separator: ", "))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                    } header:{
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
                } header:{
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
    
    private func toggleSelection<T: Equatable>(item: T, in array: inout [T], allValue: T) {
        if let index = array.firstIndex(of: item) {
            array.remove(at: index)
            if array.isEmpty {
                array.append(allValue)
            }
        } else {
            if let allIndex = array.firstIndex(of: allValue) {
                array.remove(at: allIndex)
            }
            array.append(item)
        }
    }
}
