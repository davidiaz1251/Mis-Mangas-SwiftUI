//
//  your.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 1/3/25.
//

import SwiftUI

struct SavedMangasList: View {
    let mangaSaved: [MangasDB]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16){
                ForEach(mangaSaved) { manga in
                    NavigationLink(value: manga) {
                        ImageView(url: URL(string: manga.url))
                            .scaledToFill()
                            .frame(width:130, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                VStack {
                                    Spacer()
                                    VStack{
                                        Text(manga.title)
                                            .font(.subheadline)
                                            .lineLimit(1)
                                        Text("Capitulo \(manga.currentChapters)/ \(manga.totalVolumes)")
                                            .font(.caption2)
                                            .padding(.bottom, 8)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundStyle(.white)
                            }
                            .scrollTargetLayout()
                    }
                }
            }
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
}

#Preview{
    SavedMangasList(mangaSaved: [MangasDB(id: 42, title: "Dragon Ball", url: URL(string: "https://cdn.myanimelist.net/images/manga/1/267793l.jpg")!, currentChapters: 1, volumesPurchased: 1, totalVolumes: 2, compvareCollection: true)])
    Spacer()
}
