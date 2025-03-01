//
//  your.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 1/3/25.
//

import SwiftUI

struct SavedMangasList: View {
    let url: URL = URL(string: "https://cdn.myanimelist.net/images/manga/3/161939l.jpg")!
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16){
                ForEach(0..<10) { index in
                    ImageView(url: url)
                        .scaledToFit()
                        .frame(width: 180)
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
                                Text("Petshop of Horror")
                                    .font(.headline)
                                Text("Capitulo 30 / 300")
                                    .font(.callout)
                                    .padding(.bottom)
                            }
                            .foregroundStyle(.white)
                        }
                        .scrollTargetLayout()
                }
            }
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview{
    SavedMangasList()
}
