import SwiftUI
import CoreData

struct NotasNegociacaoView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: NotaNegociacao.fetch(), animation: .default)
    private var notasNegociacao: FetchedResults<NotaNegociacao>
    
    @ObservedObject var notaViewModel: NotaViewModel
    
    func teste(_ nota: NotaNegociacao) -> some View {
        notaViewModel.editarNota(nota)
        return AdicionarEditarNotaView(notaViewModel: notaViewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(notasNegociacao) { nota in
                        NavigationLink {
                            AdicionarEditarNotaView(notaViewModel: notaViewModel)
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
                        notaViewModel.novaNotaAberta.toggle()
                        notaViewModel.novaNota()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                if notasNegociacao.count == 0 {
                    Text("Não há notas de negociação registradas")
                        .foregroundColor(.gray)
                }
            }
        }.sheet(isPresented: $notaViewModel.novaNotaAberta) {
            AdicionarEditarNotaView(notaViewModel: notaViewModel)
        }
    }
    
    private func deletarNota(index: IndexSet) {
        withAnimation {
            NotaNegociacao.deletarNotaNegociacao(posicao: index, de: Array(notasNegociacao))
            PersistenceController.shared.save()
        }
    }
}

struct NotasNegociacaoView_Previews: PreviewProvider {
    static var previews: some View {
        NotasNegociacaoView(notaViewModel: NotaViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
