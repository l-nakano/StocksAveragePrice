import Foundation

extension NotaNegociacao {
    func getDataFormatada() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM y"
        formatter.locale = Locale(identifier: "pt-br")
        return formatter.string(from: self.dataOperacao)
    }
}
