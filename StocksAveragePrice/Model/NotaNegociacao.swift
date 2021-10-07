import Foundation

struct NotaNegociacao: Identifiable {
    var id: UUID
    
    // MARK: - Taxas de Clearing
    var valorLiquidoOperacoes: Double
    var taxaLiquidacao: Double
    var taxaRegistro: Double
    
    // MARK: - Taxas da Bolsa
    var taxaTermoOpcoes: Double
    var taxaANA: Double
    var emolumentos: Double
    
    // MARK: - Custos Operacionais
    var taxaOperacional: Double
    var execucao: Double
    var taxaCustodia: Double
    var impostos: Double
    var IRRF: Double
    var outros: Double
    
    // MARK: - Ações Contidas na Nota de Negociação
    var listaAcoes: [Acao]
    
    // MARK: - Outras Informações
    var dataOperacao: Date
}
