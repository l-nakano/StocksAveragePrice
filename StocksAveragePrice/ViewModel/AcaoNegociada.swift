import CoreData

extension AcaoNegociada {
    convenience init(ticker: String, operacao: TipoOperacao, preco: Double, quantidade: Double, context: NSManagedObjectContext) {
        self.init(context: context)
        self.ticker_ = ticker
        self.operacao = operacao.rawValue
        self.preco = preco
        self.quantidade = quantidade
    }
    
    var ticker: String {
        get {
            ticker_ ?? ""
        }
        set {
            ticker_ = newValue
        }
    }
    
    static func sample(context: NSManagedObjectContext) -> [AcaoNegociada] {
        return [AcaoNegociada(ticker: "ITUB3", operacao: .compra, preco: 22.45, quantidade: 3, context: context),
                AcaoNegociada(ticker: "VALE3", operacao: .compra, preco: 75.85, quantidade: 10, context: context)]
    }
}

@objc enum TipoOperacao: Int32 {
    case venda = 0
    case compra = 1
}
