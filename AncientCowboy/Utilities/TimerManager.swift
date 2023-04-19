import Foundation

/// Менеджер для работы с таймерами
struct TimerManager {
  
  
  // MARK: - Parameters
  
  static var heroAttackTimer = Timer.publish(every: 0.1, on: .main, in: .common)
  
  static func runTimer(_ timer: TimerEnum) {
    switch timer {
    case .fight:
      _ = heroAttackTimer.connect()
    }
  }
  
  static func stopTimer(_ timer: TimerEnum) {
    switch timer {
    case .fight:
      heroAttackTimer.connect().cancel()
    }
  }
}
