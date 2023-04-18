import Foundation

struct LocationModel: Codable {
  var name: String
  var monsters: [Int: Int]
}

extension LocationModel {
  static var initial: LocationModel = LocationModel(
    name: "prt_field08",
    monsters: [
      1014: 148,
      1024: 31,
      1025: 31,
      1080: 10,
      1083: 1
    ]
  )
}
