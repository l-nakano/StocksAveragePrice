import Foundation

class NotasListViewModel: ObservableObject {
    @Published var notas: [NotaNegociacao] = []
    
    init() {
        notas = [NotaNegociacao.sample()]
    }
    
    func removerNotaNegociacao(at indexSet: IndexSet) {
        for index in indexSet {
            notas.remove(at: index)
        }
    }
}
