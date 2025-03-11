//
//  DataPreviewDB.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 9/3/25.
//

import SwiftUI
import SwiftData

struct DataPreviewDB: PreviewModifier {
    
    static func makeSharedContext() throws -> ModelContainer{
        let configuration = ModelConfiguration (isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: MangasDB.self,
                                           configurations: configuration)
        return container
    }
    func body (content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}
extension PreviewTrait where T == Preview.ViewTraits{
    @MainActor static var sampleData: Self = .modifier(DataPreviewDB())
}
