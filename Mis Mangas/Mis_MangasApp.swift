//
//  Mis_MangasApp.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 7/12/24.
//

import SwiftUI

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
                
                Text("Favorito")
                    .tabItem {
                        Label("Favorite", systemImage: "heart")
                    }
            }
            .environment(vm)
        }
    }
}

struct MangasVMKey: @preconcurrency EnvironmentKey {
    @MainActor static var defaultValue: MangasVM { MangasVM() }
}

// Extensión de EnvironmentValues
extension EnvironmentValues {
    var mangasVM: MangasVM {
        get { self[MangasVMKey.self] }
        set { self[MangasVMKey.self] = newValue }
    }
}

