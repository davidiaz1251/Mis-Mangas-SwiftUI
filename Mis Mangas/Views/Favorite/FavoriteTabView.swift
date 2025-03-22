//
//  FavoriteTabView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero on 16/3/25.
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
