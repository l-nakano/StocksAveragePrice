import SwiftUI

struct AdicionarEditarNotaView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @FetchRequest(fetchRequest: NotaNegociacao.fetch(), animation: .default)
    private var notasNegociacao: FetchedResults<NotaNegociacao>
    
    @ObservedObject var notaViewModel: NotaViewModel
    
    private let formatoMoeda: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyDecimalSeparator = ","
        formatter.currencySymbol = "R$ "
        formatter.numberStyle = .currency
        return formatter
    }()
    
    private let formatoInteiro: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
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
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Salvar")
            })
        }
    }
    
    var custoOperacional: some View {
        Section(header: Text("CUSTO OPERACIONAL")) {
            TextField("Taxa operacional", value: $notaViewModel.taxaOperacional, formatter: formatoMoeda)
            TextField("Execução", value: $notaViewModel.execucao, formatter: formatoMoeda)
            TextField("Taxa de custódia", value: $notaViewModel.taxaCustodia, formatter: formatoMoeda)
            TextField("Impostos", value: $notaViewModel.impostos, formatter: formatoMoeda)
            TextField("I.R.R.F.", value: $notaViewModel.irrf, formatter: formatoMoeda)
            TextField("Outros", value: $notaViewModel.outros, formatter: formatoMoeda)
        }
    }
    
    var bolsa: some View {
        Section(header: Text("BOLSA")) {
            TextField("Taxa de termo/opções", value: $notaViewModel.taxaTermoOpcoes, formatter: formatoMoeda)
            TextField("Taxa A.N.A.", value: $notaViewModel.taxaANA, formatter: formatoMoeda)
            TextField("Emolumentos", value: $notaViewModel.emolumentos, formatter: formatoMoeda)
        }
    }
    
    var clearing: some View {
        Section(header: Text("CLEARING")) {
            TextField("Valor líquido das operações", value: $notaViewModel.valorLiquidoOperacoes, formatter: formatoMoeda)
            TextField("Taxa de liquidação", value: $notaViewModel.taxaLiquidacao, formatter: formatoMoeda)
            TextField("Taxa de registro", value: $notaViewModel.taxaRegistro, formatter: formatoMoeda)
        }
    }
    
    var acao: some View {
        Section(header: Text("PAPÉIS")) {
            HStack {
                Text("Ação")
                    .frame(maxWidth: .infinity)
                Text("Operação")
                    .frame(maxWidth: .infinity)
                Text("Quantidade")
                    .frame(maxWidth: .infinity)
                Text("Preço")
                    .frame(maxWidth: .infinity)
            }
            .font(.callout)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            if notaViewModel.acoes.count > 0 {
                ForEach(notaViewModel.acoes.indices, id: \.self) { index in
                    HStack {
                        TextField("Ticker", text: $notaViewModel.acoes[index].ticker)
                            .frame(maxWidth: .infinity)
                        if notaViewModel.acoes[index].operacao == 0 {
                            Text("V")
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("C")
                                .frame(maxWidth: .infinity)
                        }
                        TextField("Quantidade", value: $notaViewModel.acoes[index].quantidade, formatter: formatoInteiro)
                            .frame(maxWidth: .infinity)
                        TextField("Preço", value: $notaViewModel.acoes[index].preco, formatter: formatoMoeda)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    adicionarNovaAcao()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                })
                Spacer()
            }
        }
    }
    
    private func adicionarNovaAcao() {
        withAnimation {
            let novaAcao = AcaoNegociada(ticker: "",
                                         operacao: .compra,
                                         preco: 0,
                                         quantidade: 0,
                                         context: viewContext)
            notaViewModel.adicionarNovaAcao(novaAcao)
            
            PersistenceController.shared.save()
        }
    }
    
    private func salvarNotaNegociacao() {
        withAnimation {
            notaViewModel.salvarNotaNegociacao(viewContext: viewContext)
        }
    }
}

struct AdicionarEditarNotaView_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarEditarNotaView(notaViewModel: NotaViewModel())
    }
}
