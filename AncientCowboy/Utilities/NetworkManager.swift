import Foundation

/// Менеджер для работы с сетевыми запросами
struct NetworkManager {
  
  static let shared = NetworkManager()
  
  private init() {}
  
  var session = URLSession(configuration: .default)
  
  func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
    
    let (data, response) = try await session.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw ApiError.requestFailed(description: "Invalid response")
    }
    
    guard httpResponse.statusCode == 200 else {
      throw ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
    }
    
    do {
      let decoder = JSONDecoder()
      
      let decoded = try decoder.decode(type, from: data)
      
      return decoded
    } catch {
      print(error)
      throw ApiError.jsonConversionFailure(description: error.localizedDescription)
    }
  }
}
