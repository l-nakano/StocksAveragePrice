import CoreData
import SwiftUI

extension Acao {
    convenience init(empresa: String, logo: Data?, ticker: String, precoMedio: Double, quantidade: Int32, saldoAtual: Double, ultimaCotacao: Double, retornoPM: Double, context: NSManagedObjectContext) {
        self.init(context: context)
        self.empresa_ = empresa
        self.logo_ = logo
        self.ticker_ = ticker
        self.precoMedio = precoMedio
        self.quantidade = quantidade
        self.saldoAtual = saldoAtual
        self.ultimaCotacao = ultimaCotacao
        self.retornoPM = retornoPM
    }
    
    var empresa: String {
        get {
            empresa_ ?? ""
        }
        set {
            empresa_ = newValue
        }
    }
    
    var ticker: String {
        get {
            ticker_ ?? ""
        }
        set {
            ticker_ = newValue
        }
    }
    
    var logo: Data {
        get {
            logo_ ?? Data()
        }
        set {
            logo_ = newValue
        }
    }
    
    static func sample(context: NSManagedObjectContext) -> [Acao] {
        return [Acao(empresa: "Itaú Unibanco",
                     logo: UIImage(systemName: "photo")?.pngData(),
                     ticker: "ITUB3",
                     precoMedio: 22.54,
                     quantidade: 100,
                     saldoAtual: 2254.0,
                     ultimaCotacao: 22.54,
                     retornoPM: 0.0,
                     context: context),
                Acao(empresa: "Vale",
                     logo: UIImage(systemName: "photo")?.pngData(),
                     ticker: "VALE3",
                     precoMedio: 75.05,
                     quantidade: 25,
                     saldoAtual: 1876.25,
                     ultimaCotacao: 75.05,
                     retornoPM: 0.0,
                     context: context)]
    }
}
