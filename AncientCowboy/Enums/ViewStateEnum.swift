/// Возможные состояния View
enum ViewStateEnum: Equatable {
  case initial
  case isLoading
  case loaded
  case failed(ViewStateError)
}
