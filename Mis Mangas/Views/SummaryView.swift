//
//  SummaryView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 30/1/25.
//

import SwiftUI

struct SummaryView: View {
    let manga: Manga
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                let details: [(label: String, value: String?)] = [
                    ("Título", manga.title),
                    ("Título en inglés", manga.titleEnglish),
                    ("Título japonés", manga.titleJapanese),
                    ("Fecha de Publicación", manga.startDate?.formatted(date: .abbreviated, time: .omitted)),
                    ("Fecha de Finalización", manga.endDate?.formatted(date: .abbreviated, time: .omitted)),
                    ("Capítulos", manga.chapters.map { "\($0)" }),
                    ("Volúmenes", manga.volumes.map { "\($0)" }),
                    ("Puntuación", "\(manga.score)"),
                    ("Estado", manga.status),
                    ("Background", manga.background),
                    ("Sinopsis", manga.sypnosis),
                    ("URL", manga.url?.absoluteString)
                ]
                
                ForEach(details, id: \.label) { label, value in
                    if let value = value {
                        if label == "URL", let url = URL(string: value) {
                            Link("Ver en MyAnimeList", destination: url)
                                .foregroundColor(.blue)
                        } else {
                            RowViewDetail(header: label, text: value)
                        }
                    }
                }
                
                if !manga.genres.isEmpty {
                    GenreListView(title: "Géneros", items: manga.genres.map { $0.rawValue })
                }
                
                if !manga.themes.isEmpty {
                    GenreListView(title: "Temas", items: manga.themes.map { $0.rawValue })
                }
                
                if !manga.demographics.isEmpty {
                    GenreListView(title: "Demografía", items: manga.demographics.map { $0.rawValue })
                }
                
                if !manga.authors.isEmpty {
                    GenreListView(title: "Autores", items: manga.authors.map { "\($0.firstName) \($0.lastName) (\($0.role))" })
                }

            }
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 50)
        }
    }
}


struct GenreListView: View {
    let title: String
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .padding(6)
                            .background(Color.blue.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding(.vertical, 6)
    }
}

struct RowViewDetail: View {
    let header: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
            Text(text)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    SummaryView(manga: NetworkTest.preview)
}
