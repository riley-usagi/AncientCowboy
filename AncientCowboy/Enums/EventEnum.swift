/// Список всех Событий в приложении
enum EventEnum: Equatable {
  case initial
  case changeRoute(RouteEnum.Action)
  case locationCleared
  case itemDropped(innerID: Int)
}

extension EventEnum {
  
  /// Список действий совершаемых при определённых событиях
  /// - Parameter event: Событие
  /// - Returns: Массив действий
  static func actionsByEvent(_ event: Self) -> [any ViewAction] {
    switch event {
    case .initial:
      return []
    case .changeRoute:
      return []
    case .locationCleared:
      return []
    case let .itemDropped(innerID):
      return [InventoryScreen.InnerAction.itemDropped(innerID: innerID)]
    }
  }
}
