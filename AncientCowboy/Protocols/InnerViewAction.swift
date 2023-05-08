/// Протокол объединяющий в себе все Действия в каждой из View
protocol InnerViewAction: Equatable {
  static var `default`: Self { get }
}
