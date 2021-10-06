import Foundation

extension NotaNegociacao {
    static func sample() -> Self {
        return NotaNegociacao(id: UUID(),
                              valorLiquidoOperacoes: 578.53,
                              taxaLiquidacao: 0.14,
                              taxaRegistro: 0.0,
                              taxaTermoOpcoes: 0.0,
                              taxaANA: 0.0,
                              emolumentos: 0.02,
                              taxaOperacional: 0.0,
                              execucao: 0.0,
                              taxaCustodia: 0.0,
                              impostos: 0.0,
                              IRRF: 0.02,
                              outros: 0.0)
    }
}
