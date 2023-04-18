import Foundation

struct ItemModel: Identifiable, Codable {
  var id: UUID = UUID()
  var innerID: Int
  var name: String
  
  enum CodingKeys: String, CodingKey {
    case innerID  = "id"
    case name     = "name_english"
  }
  
  init(innerID: Int, name: String) {
    self.innerID  = innerID
    self.name     = name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.name = try container.decode(String.self, forKey: .name)
    
    let innerIDasString = try container.decode(String.self, forKey: .innerID)
    
    guard let tempInnerId = Int(innerIDasString) else {
      throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
    }
    
    self.innerID  = tempInnerId
  }
}
