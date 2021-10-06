import Foundation

class NotasListViewModel: ObservableObject {
    @Published var notas: [NotaNegociacao] = [NotaNegociacao.sample()]
    
    init() {
        
    }
}
