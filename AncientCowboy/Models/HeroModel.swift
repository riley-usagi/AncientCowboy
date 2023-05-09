import Foundation

struct HeroModel: Codable {
  var name: String
  var hp: Int   = 1000
  var atk: Int  = 10
  var exp: Int  = 0
  var currentLocation: LocationModel = .initial
}

extension HeroModel {
  static var stub: HeroModel = HeroModel(name: "Stub")
}

extension HeroModel {
  static var current: HeroModel = HeroModel(name: "Riley")
}
