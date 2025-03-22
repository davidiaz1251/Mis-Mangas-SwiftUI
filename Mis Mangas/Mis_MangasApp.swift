//
//  Mis_MangasApp.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 7/12/24.
//

import SwiftUI
import SwiftData

@main
struct Mis_MangasApp: App {
    @State var vm = MangasVM()
    var body: some Scene {
        WindowGroup {
            TabView{
                ContentView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SearchMangaView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                FavoriteTabView()
                    .tabItem {
                        Label("Favorite", systemImage: "heart")
                    }
            }
            .environment(vm)
        }
        .modelContainer(for: MangasDB.self)
    }
}
