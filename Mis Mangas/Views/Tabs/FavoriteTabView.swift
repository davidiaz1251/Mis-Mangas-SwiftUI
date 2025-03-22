//
//  FavoriteTabView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 22/3/25.
//


import SwiftUI

struct FavoriteTabView: View {
    var body: some View {
        NavigationStack{
            FavoriteView()
                .navigationTitle("Favoritos")
        }
    }
}

#Preview {
    FavoriteTabView()
}
