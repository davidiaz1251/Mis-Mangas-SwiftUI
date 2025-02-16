//
//  SearchListView.swift
//  Mis Mangas
//
//  Created by Alex Guerrero Flores on 16/2/25.
//

import SwiftUI

struct SearchListView: View {
    @Environment(MangasVM.self) private var vm: MangasVM
    let category: BasicFilterCategory
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchListView(category: .genres)
        .environment(MangasVM(network: NetworkTest()))
}
