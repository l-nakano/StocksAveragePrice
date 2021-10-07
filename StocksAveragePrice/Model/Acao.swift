import Foundation
import SwiftUI

struct Acao {
    var id: UUID
    
    // MARK: - Informação do Papel
    var empresa: String
    var logo: Image
    var ticker: String
    var precoMedio: Double
    var quantidade: Int
    var saldoAtual: Double
    
    // MARK: - Informação na Bolsa
    var ultimaCotacao: Double
    var retornoPM: Double
    
    // MARK: - Histórico de Operações
    var historico: HistoricoOperacoes
}
