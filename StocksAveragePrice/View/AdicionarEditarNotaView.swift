import SwiftUI

struct AdicionarEditarNotaView: View {
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
        VStack(spacing: 0) {
            if notaViewModel.notaNegociacao == nil {
                HStack {
                    Button(action: {
                        notaViewModel.novaNotaAberta.toggle()
                    }, label: {
                        Text("Cancelar")
                    })
                    Spacer()
                    Button(action: {
                        salvarNotaNegociacao()
                        notaViewModel.novaNotaAberta.toggle()
                    }, label: {
                        Text("Salvar")
                    })
                }.padding(20)
            }
            List {
                clearing
                bolsa
                custoOperacional
                acao
            }
            .listStyle(.insetGrouped)
        }
        .toolbar {
            Button(action: {
                salvarNotaNegociacao()
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
                HStack {
                    Text(acao.ticker)
                    if acao.operacao == 0 {
                        Text("V")
                    } else {
                        Text("C")
                    }
                    Text(String(acao.quantidade))
                    Text(String(acao.preco))
                }
            }
        }
    }
    
    private func salvarNotaNegociacao() {
        withAnimation {
            _ = NotaNegociacao(
                valorLiquidoOperacoes: notaViewModel.valorLiquidoOperacoes,
                taxaLiquidacao: notaViewModel.taxaLiquidacao,
                taxaRegistro: notaViewModel.taxaRegistro,
                taxaTermoOpcoes: notaViewModel.taxaTermoOpcoes,
                taxaANA: notaViewModel.taxaANA,
                emolumentos: notaViewModel.emolumentos,
                taxaOperacional: notaViewModel.taxaOperacional,
                execucao: notaViewModel.execucao,
                taxaCustodia: notaViewModel.taxaCustodia,
                impostos: notaViewModel.impostos,
                IRRF: notaViewModel.irrf,
                outros: notaViewModel.outros,
                dataOperacao: Date(),
                context: viewContext)
            
            PersistenceController.shared.save()
        }
    }
}

struct AdicionarEditarNotaView_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarEditarNotaView(notaViewModel: NotaViewModel())
    }
}
