import SwiftUI
import CoreData

@main
struct StocksAveragePriceApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NotasNegociacaoView(notaViewModel: NotaViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
