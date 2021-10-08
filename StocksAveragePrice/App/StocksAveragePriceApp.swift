import SwiftUI
import CoreData

@main
struct StocksAveragePriceApp: App {
    let persistenceController = PersistenceController.preview
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NotasNegociacaoView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
