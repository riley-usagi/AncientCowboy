import Foundation

/// Все Роуты приложения
enum RouteEnum: Hashable {
  case loading
  case content
}

extension RouteEnum {
  
  /// Действия с роутами
  enum Action: Equatable {
    case back
    case backToRoot
    case goTo(RouteEnum)
    case replaceTo(RouteEnum)
  }
}
