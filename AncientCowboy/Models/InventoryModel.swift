import Foundation

struct InventoryModel: Codable, Identifiable {
  var id: UUID = UUID()
  var innerID: Int
  var count: Int = 1
}

extension InventoryModel {
  
  static func all() async -> [InventoryModel] {
    var items: [InventoryModel] = []
    
    do {
      items = try await CoreDataManager.shared.read(request: InventoryCD.fetchRequest())
    } catch {
      print(error)
    }
    
    return items
  }
  
  static func getDropFrom(_ enemy: MonsterModel) async {
    
    let dice = Double.random(in: 0.01..<100)
    
    do {
      
      if dice <= Double((enemy.drop1per / 100)) {
        
        if let invetoryCD = try await CoreDataManager.shared.read(request: InventoryCD.by(innerID: enemy.drop1id)).first {
          
          InventoryCD.update(invetoryCD.innerID)
          
          DispatchQueue.main.async {          
            eventSubject.send(.itemDropped(innerID: enemy.drop1id))
          }
        } else {
          InventoryCD.create(InventoryModel(innerID: enemy.drop1id))
        }
        
      } else {
        print("Dropped nothing")
      }
      
    } catch {
      print(error)
    }
  }
}
