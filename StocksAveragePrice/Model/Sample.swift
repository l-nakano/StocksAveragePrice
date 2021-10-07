import SwiftUI

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
                              outros: 0.0,
                              listaAcoes: [Acao.sample()],
                              dataOperacao: Date())
    }
}

extension Acao {
    static func sample() -> Self {
        return Acao(id: UUID(),
                    empresa: "Itaú Unibanco",
                    logo: Image(systemName: "photo"),
                    ticker: "ITUB3",
                    precoMedio: 22.54,
                    quantidade: 100,
                    saldoAtual: 2254.0,
                    ultimaCotacao: 22.54,
                    retornoPM: 0.0,
                    historico: HistoricoOperacoes.sample())
    }
}

extension HistoricoOperacoes {
    static func sample() -> Self {
        return HistoricoOperacoes(id: UUID(),
                                  dataOperacao: Date(),
                                  precoMedio: 22.54)
    }
}
