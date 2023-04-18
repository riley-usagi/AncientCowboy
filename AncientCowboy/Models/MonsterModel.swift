import SwiftUI

struct MonsterModel: Identifiable, Codable {
  var id: UUID = UUID()
  var innerID: Int
  var name: String
  var atk1: Int
  var hp: Int
  var drop1id: Int
  var drop1per: Int
  
  enum CodingKeys: String, CodingKey {
    case innerID  = "ID"
    case name     = "iName"
    case atk1     = "ATK1"
    case hp       = "HP"
    case drop1id  = "Drop1id"
    case drop1per = "Drop1per"
  }
  
  init(innerID: Int, name: String, atk1: Int, hp: Int, drop1id: Int, drop1per: Int) {
    self.innerID = innerID
    self.name = name
    self.atk1 = atk1
    self.hp = hp
    self.drop1id = drop1id
    self.drop1per = drop1per
  }
  
  init(from decoder: Decoder) throws {
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.name = try container.decode(String.self, forKey: .name)
    
    let innerIDasString   = try container.decode(String.self, forKey: .innerID)
    let atkAsString       = try container.decode(String.self, forKey: .atk1)
    let hpAsString        = try container.decode(String.self, forKey: .hp)
    let drop1idAsString   = try container.decode(String.self, forKey: .drop1id)
    let drop1perAsString  = try container.decode(String.self, forKey: .drop1per)
    
    guard let tempInnerId = Int(innerIDasString) else {
      throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
    }
    
    guard let tempAtk = Int(atkAsString) else {
      throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
    }
    
    guard let tempHP = Int(hpAsString) else {
      throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
    }
    
    guard let tempDrop1id = Int(drop1idAsString) else {
      throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
    }
    
    guard let tempDrop1Per = Int(drop1perAsString) else {
      throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
    }
    
    self.innerID  = tempInnerId
    self.atk1     = tempAtk
    self.hp       = tempHP
    self.drop1id  = tempDrop1id
    self.drop1per = tempDrop1Per
  }
}


// MARK: - Methods

extension MonsterModel {
  
  static func monstersFrom(_ location: LocationModel) async -> [MonsterModel] {
    
    var monsters: [MonsterModel] = []
    
    for (id, count) in location.monsters {
      
      do {
        
        if var tempMonster = try await CoreDataManager.shared.read(request: MonsterCD.by(id: id)).first {
          for _ in 0..<count {
            tempMonster.id = UUID()
            monsters.append(tempMonster)
          }
        }
        
      } catch {
        print(error)
      }
    }
    
    return monsters
  }
}

extension MonsterModel: ToUnSafeObject {
  
  func unSafeObject() throws -> MonsterCD {
    let monsterCD = MonsterCD()
    
    monsterCD.id        = UUID()
    monsterCD.innerID   = Int32(innerID)
    monsterCD.name      = name
    monsterCD.hp        = Int32(hp)
    monsterCD.drop1id   = Int32(drop1id)
    monsterCD.drop1per  = Int32(drop1per)
    
    return monsterCD
  }
}


// MARK: - Stubs

extension MonsterModel {
  static var stub = MonsterModel(innerID: 0, name: "Stub", atk1: 1, hp: 100, drop1id: 1, drop1per: 1)
}
