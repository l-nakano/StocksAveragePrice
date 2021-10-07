import SwiftUI

struct NotasNegociacaoView: View {
    @ObservedObject var notasViewModel: NotasListViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(notasViewModel.notas) { nota in
                        NavigationLink(
                            destination: Text("Destination \(nota.dataOperacao)"),
                            label: {
                                Text("\(nota.getDataFormatada())")
                            })
                    }
                    .onDelete { indexSet in
                        notasViewModel.removerNotaNegociacao(at: indexSet)
                    }
                }
                .navigationBarTitle(Text("Notas de Negociação"), displayMode: .inline)
                .toolbar {
                    Button(action: {
                        print("Adicionou")
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                if notasViewModel.notas.count == 0 {
                    Text("Não há notas de negociação registradas")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct NotasNegociacao_Previews: PreviewProvider {
    static var previews: some View {
        NotasNegociacaoView(notasViewModel: NotasListViewModel())
    }
}
