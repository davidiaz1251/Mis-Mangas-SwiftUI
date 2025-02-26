//
//  LoadingView.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 23/2/25.
//

import SwiftUI

struct LoadingView<Content: View>: View {
    let loading: Bool
    let data: Bool
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content, data: Bool, loading: Bool) {
        self.content = content
        self.data = data
        self.loading = loading
    }
    var body: some View {
        VStack {
            if loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if data {
                content()
            } else {
                Text("No hay información.")
            }
        }
    }
}

#Preview {
    LoadingView(content: {
        Text("Contenido cargado exitosamente.")
            .padding()
    },data: true, loading: false)
}
