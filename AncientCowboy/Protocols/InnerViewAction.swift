/// Протокол объединяющий в себе все Действия в каждой из View
protocol ViewAction: Equatable {
  static var `default`: Self { get }
}
