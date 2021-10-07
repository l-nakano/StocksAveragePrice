import SwiftUI

@main
struct StocksAveragePriceApp: App {
    @StateObject var notasViewModel = NotasListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NotasNegociacaoView(notasViewModel: notasViewModel)
        }
    }
}
