import Foundation
import Combine

class NotaViewModel: ObservableObject {

    @Published var valorLiquidoOperacoes = 0.0
    @Published var taxaLiquidacao = 0.0
    @Published var taxaRegistro = 0.0
    @Published var taxaTermoOpcoes = 0.0
    @Published var taxaANA = 0.0
    @Published var emolumentos = 0.0
    @Published var taxaOperacional = 0.0
    @Published var execucao = 0.0
    @Published var taxaCustodia = 0.0
    @Published var impostos = 0.0
    @Published var irrf = 0.0
    @Published var outros = 0.0
    @Published var acoes = [Acao]()
    
    @Published var notaNegociacao: NotaNegociacao!
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $notaNegociacao.sink { [unowned self] nota in
            self.valorLiquidoOperacoes = nota?.valorLiquidoOperacoes ?? 0.0
            self.taxaLiquidacao = nota?.taxaLiquidacao ?? 0.0
            self.taxaRegistro = nota?.taxaRegistro ?? 0.0
            self.taxaTermoOpcoes = nota?.taxaTermoOpcoes ?? 0.0
            self.taxaANA = nota?.taxaANA ?? 0.0
            self.emolumentos = nota?.emolumentos ?? 0.0
            self.taxaOperacional = nota?.taxaOperacional ?? 0.0
            self.execucao = nota?.execucao ?? 0.0
            self.taxaCustodia = nota?.taxaCustodia ?? 0.0
            self.impostos = nota?.impostos ?? 0.0
            self.irrf = nota?.irrf ?? 0.0
            self.outros = nota?.outros ?? 0.0
            self.acoes = Array(nota?.listaAcoes as? Set<Acao> ?? [])
        }.store(in: &subscriptions)
    }
    
    func novaNota() {
        notaNegociacao = nil
    }
    
    func editarNota(_ nota: NotaNegociacao) {
        notaNegociacao = nota
    }
}

extension String {
    func stringParaDouble(_ s: String) -> Double {
        return Double(s)!
    }
}
