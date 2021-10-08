import SwiftUI
import CoreData

struct NotasNegociacaoView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: NotaNegociacao.fetch(), animation: .default)
    private var notasNegociacao: FetchedResults<NotaNegociacao>
    
    @State private var novaNotaAberta = false
    
    @ObservedObject var notaViewModel: NotaViewModel
    
    func teste(_ nota: NotaNegociacao) -> some View {
        notaViewModel.editarNota(nota)
        return AdicionarEditarNota(notaViewModel: notaViewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(notasNegociacao) { nota in
                        NavigationLink {
                            AdicionarEditarNota(notaViewModel: notaViewModel)
                                .onAppear(perform: { notaViewModel.editarNota(nota) })
                        } label: {
                            Text("\(nota.dataFormatada())")
                        }
                    }
                    .onDelete { indexSet in
                        deletarNota(index: indexSet)
                    }
                }
                .navigationBarTitle(Text("Notas de Negociação"), displayMode: .inline)
                .toolbar {
                    Button(action: {
                        novaNotaAberta.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                if notasNegociacao.count == 0 {
                    Text("Não há notas de negociação registradas")
                        .foregroundColor(.gray)
                }
            }
        }.sheet(isPresented: $novaNotaAberta) {
            AdicionarEditarNota(notaViewModel: notaViewModel)
                .onAppear(perform: { notaViewModel.novaNota() })
        }
    }
    
    private func deletarNota(index: IndexSet) {
        withAnimation {
            NotaNegociacao.deletarNotaNegociacao(posicao: index, de: Array(notasNegociacao))
            PersistenceController.shared.save()
        }
    }
    
    private func addItem() {
        withAnimation {
            _ = NotaNegociacao(valorLiquidoOperacoes: 0.0, taxaLiquidacao: 0.0, taxaRegistro: 0.0, taxaTermoOpcoes: 0.0, taxaANA: 0.0, emolumentos: 0.0, taxaOperacional: 0.0, execucao: 0.0, taxaCustodia: 0.0, impostos: 0.0, IRRF: 0.0, outros: 0.0, dataOperacao: Date(), context: viewContext)

            PersistenceController.shared.save()
        }
    }
}

struct NotasNegociacao_Previews: PreviewProvider {
    static var previews: some View {
        NotasNegociacaoView(notaViewModel: NotaViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
