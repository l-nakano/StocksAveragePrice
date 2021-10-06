import SwiftUI

struct AddNovaNotaView: View {
    @ObservedObject var notasViewModel: NotasListViewModel
    
    var body: some View {
        Text(String(notasViewModel.notas.first!.valorLiquidoOperacoes))
            .padding()
    }
}

struct AddNovaNotaView_Previews: PreviewProvider {
    static var previews: some View {
        AddNovaNotaView(notasViewModel: NotasListViewModel())
    }
}
