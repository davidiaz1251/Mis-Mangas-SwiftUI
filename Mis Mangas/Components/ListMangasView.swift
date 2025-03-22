//
//  ListMangasView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 1/3/25.
//

import SwiftUI

struct ListMangasView: View {
    let mangas: [Manga]
    var body: some View {
        ForEach(mangas){manga in
            NavigationLink(value: manga) {
                HStack{
                    ImageView(url: manga.mainPicture)
                        .scaledToFill()
                        .frame(width: 100,height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                    VStack(alignment: .leading){
                        Text(manga.title)
                        Text(manga.titleJapanese)
                        HStack{
                            Text("Capítulos: \(manga.chapters ?? 0)")
                            Text("|")
                            Text("Volúmenes: \(manga.volumes ?? 0)")
                        }
                        HStack{
                            Text("\(manga.formattedGenres())")
                                .font(.subheadline)
                        }
                        Text("Score: \(manga.score.formatted(withDecimals: 2))")
                        Spacer()
                    }
                    Spacer()
                }
                .frame(height: 150)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview{
    NavigationStack{
        ListMangasView(mangas: [NetworkTest.preview])
        Spacer()
    }
}
