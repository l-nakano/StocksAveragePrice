import CoreData

extension NotaNegociacao {
    convenience init(valorLiquidoOperacoes: Double, taxaLiquidacao: Double, taxaRegistro: Double, taxaTermoOpcoes: Double, taxaANA: Double, emolumentos: Double, taxaOperacional: Double, execucao: Double, taxaCustodia: Double, impostos: Double, IRRF: Double, outros: Double, dataOperacao: Date, context: NSManagedObjectContext) {
        self.init(context: context)
        self.valorLiquidoOperacoes = valorLiquidoOperacoes
        self.taxaLiquidacao = taxaLiquidacao
        self.taxaRegistro = taxaRegistro
        self.taxaTermoOpcoes = taxaTermoOpcoes
        self.taxaANA = taxaANA
        self.emolumentos = emolumentos
        self.taxaOperacional = taxaOperacional
        self.execucao = execucao
        self.taxaCustodia = taxaCustodia
        self.impostos = impostos
        self.irrf = IRRF
        self.outros = outros
        self.dataOperacao_ = dataOperacao
    }
    
    var dataOperacao: Date {
        get {
            dataOperacao_ ?? Date()
        }
        set {
            dataOperacao_ = newValue
        }
    }
    
    static func deletarNotaNegociacao(posicao indexSet: IndexSet, de notas: [NotaNegociacao]) {
        if let primeiraNota = notas.first, let viewContext = primeiraNota.managedObjectContext {
            indexSet.map { notas[$0] }.forEach(viewContext.delete)
        }
    }
    
    static func fetch() -> NSFetchRequest<NotaNegociacao> {
        let request = NSFetchRequest<NotaNegociacao>(entityName: "NotaNegociacao")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NotaNegociacao.dataOperacao_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        return request
    }
    
    func dataFormatada() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM y"
        formatter.locale = Locale(identifier: "pt-br")
        return formatter.string(from: self.dataOperacao)
    }
    
    static func sample(context: NSManagedObjectContext) -> NotaNegociacao {
        return NotaNegociacao(valorLiquidoOperacoes: 578.53,
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
                              dataOperacao: Date(),
                              context: context)
    }
}
