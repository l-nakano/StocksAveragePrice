import Foundation
import Combine
import CoreData

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
    @Published var acoes = [AcaoNegociada]()
    
    @Published var notaNegociacao: NotaNegociacao!
    
    @Published var novaNotaAberta = false
    @Published var alertaSalvar = false
    
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
            self.acoes = Array(nota?.listaAcoes as? Set<AcaoNegociada> ?? [])
        }.store(in: &subscriptions)
    }
    
    func novaNota() {
        notaNegociacao = nil
    }
    
    func editarNota(_ nota: NotaNegociacao) {
        notaNegociacao = nota
    }
    
    func adicionarNovaAcao(_ acao: AcaoNegociada) {
        acoes.append(acao)
    }
    
    func insereOperacaoVenda(index: Int) {
        acoes[index].operacao = 0
        self.objectWillChange.send()
    }
    
    func insereOperacaoCompra(index: Int) {
        acoes[index].operacao = 1
        self.objectWillChange.send()
    }
    
    func salvarNotaNegociacao(viewContext: NSManagedObjectContext) {
        if valorLiquidoOperacoes == 0 || acoes.count == 0 {
            alertaSalvar.toggle()
        } else {
            if notaNegociacao == nil {
                let novaNota = NotaNegociacao(valorLiquidoOperacoes: valorLiquidoOperacoes,
                                   taxaLiquidacao: taxaLiquidacao,
                                   taxaRegistro: taxaRegistro,
                                   taxaTermoOpcoes: taxaTermoOpcoes,
                                   taxaANA: taxaANA,
                                   emolumentos: emolumentos,
                                   taxaOperacional: taxaOperacional,
                                   execucao: execucao,
                                   taxaCustodia: taxaCustodia,
                                   impostos: impostos,
                                   IRRF: irrf,
                                   outros: outros,
                                   dataOperacao: Date(),
                                   context: viewContext)
                novaNota.addToListaAcoes(NSSet(array: acoes))
            } else {
                notaNegociacao.valorLiquidoOperacoes = valorLiquidoOperacoes
                notaNegociacao.taxaLiquidacao = taxaLiquidacao
                notaNegociacao.taxaRegistro = taxaRegistro
                notaNegociacao.taxaTermoOpcoes = taxaTermoOpcoes
                notaNegociacao.taxaANA = taxaANA
                notaNegociacao.emolumentos = emolumentos
                notaNegociacao.taxaOperacional = taxaOperacional
                notaNegociacao.execucao = execucao
                notaNegociacao.taxaCustodia = taxaCustodia
                notaNegociacao.impostos = impostos
                notaNegociacao.irrf = irrf
                notaNegociacao.outros = outros
                notaNegociacao.dataOperacao = Date()
                notaNegociacao.addToListaAcoes(NSSet(array: acoes))
            }
            
            PersistenceController.shared.save()
        }
    }
}

extension String {
    func stringParaDouble(_ s: String) -> Double {
        return Double(s)!
    }
}
