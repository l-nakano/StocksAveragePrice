import CoreData

extension HistoricoOperacoes {
    convenience init(dataOperacao: Date, precoMedio: Double, context: NSManagedObjectContext) {
        self.init(context: context)
        self.dataOperacao_ = dataOperacao
        self.precoMedio = precoMedio
    }
    
    var dataOperacao: Date {
        get {
            dataOperacao_ ?? Date()
        }
        set {
            dataOperacao_ = newValue
        }
    }
    
    static func sample(context: NSManagedObjectContext) -> HistoricoOperacoes {
        return HistoricoOperacoes(dataOperacao: Date(),
                                  precoMedio: 22.54,
                                  context: context)
    }
}
