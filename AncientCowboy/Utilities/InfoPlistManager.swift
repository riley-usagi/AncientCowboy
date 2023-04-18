import Foundation

/// Менеджер для работы с Info.plist
struct InfoPlistManager {
  
  static let shared = InfoPlistManager()
  
  private init() {}
  
  func values() -> [String: AnyObject]? {
    guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else {
      return nil
    }
    
    guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
      return nil
    }
    
    return dictionary
  }
  
}
