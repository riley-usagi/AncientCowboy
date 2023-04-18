import Foundation

/// Ошибки изменения статуса View
enum ViewStateError: Error {
  case error
  
  var customDescription: String {
    switch self {
      
    case .error:
      return "Error of changing view state"
    }
  }
}
