import SwiftUI

struct AdicionarEditarNota: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: NotaNegociacao.fetch(), animation: .default)
    private var notasNegociacao: FetchedResults<NotaNegociacao>
    
    @ObservedObject var notaViewModel: NotaViewModel
    
    private let formatoNumero: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyDecimalSeparator = ","
        formatter.currencySymbol = "R$ "
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        List {
            clearing
            bolsa
            custoOperacional
            acao
        }
        .listStyle(.insetGrouped)
        .toolbar {
            Button(action: {
                print("Alo")
            }, label: {
                Text("Salvar")
            })
        }
    }
    
    var custoOperacional: some View {
        Section(header: Text("CUSTO OPERACIONAL")) {
            TextField("Taxa operacional", value: $notaViewModel.taxaOperacional, formatter: formatoNumero)
            TextField("Execução", value: $notaViewModel.execucao, formatter: formatoNumero)
            TextField("Taxa de custódia", value: $notaViewModel.taxaCustodia, formatter: formatoNumero)
            TextField("Impostos", value: $notaViewModel.impostos, formatter: formatoNumero)
            TextField("I.R.R.F.", value: $notaViewModel.irrf, formatter: formatoNumero)
            TextField("Outros", value: $notaViewModel.outros, formatter: formatoNumero)
        }
    }
    
    var bolsa: some View {
        Section(header: Text("BOLSA")) {
            TextField("Taxa de termo/opções", value: $notaViewModel.taxaTermoOpcoes, formatter: formatoNumero)
            TextField("Taxa A.N.A.", value: $notaViewModel.taxaANA, formatter: formatoNumero)
            TextField("Emolumentos", value: $notaViewModel.emolumentos, formatter: formatoNumero)
        }
    }
    
    var clearing: some View {
        Section(header: Text("CLEARING")) {
            TextField("Valor líquido das operações", value: $notaViewModel.valorLiquidoOperacoes, formatter: formatoNumero)
            TextField("Taxa de liquidação", value: $notaViewModel.taxaLiquidacao, formatter: formatoNumero)
            TextField("Taxa de registro", value: $notaViewModel.taxaRegistro, formatter: formatoNumero)
        }
    }
    
    var acao: some View {
        Section(header: Text("PAPÉIS")) {
            ForEach(notaViewModel.acoes) { acao in
                Text(acao.ticker)
            }
            Text("Teste")
        }
    }
}

struct AdicionarEditarNota_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarEditarNota(notaViewModel: NotaViewModel())
    }
}
