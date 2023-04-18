import CoreData
import Foundation

@objc(InventoryCD) public class InventoryCD: NSManagedObject, Identifiable {
  @NSManaged public var innerID: Int32
  @NSManaged public var count: Int32
}


// MARK: - Methods

extension InventoryCD {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<InventoryCD> {
    return NSFetchRequest<InventoryCD>(entityName: "InventoryCD")
  }
  
  @nonobjc public class func by(innerID: Int) -> NSFetchRequest<InventoryCD> {
    
    let request         = fetchRequest()
    let predicate       = NSPredicate(format: "innerID == %@", String(innerID))
    request.predicate   = predicate
    request.fetchLimit  = 1
    
    return request
  }
  
  static func create(_ inventoryModel: InventoryModel) {
    
    let context       = CoreDataManager.shared.container.viewContext
    let inventoryItem = InventoryCD(context: context)
    
    inventoryItem.innerID = Int32(inventoryModel.innerID)
    
    do {
      try context.save()
    } catch let error as NSError {
      debugPrint(error)
    }
  }
  
  static func update(_ innerID: Int) {
    
    let context       = CoreDataManager.shared.container.viewContext
    let fetchRequest  = InventoryCD.by(innerID: innerID)
    
    do {
      
      guard let result = try context.fetch(fetchRequest).first else {
        return
      }
      
      result.setValue(result.count + 1, forKey: "count")
      
      do {
        try context.save()
      } catch let error as NSError {
        debugPrint(error)
      }
    } catch {
      debugPrint(error)
    }
  }
}

extension InventoryCD: ToSafeObject {
  
  func safeObject() throws -> InventoryModel {
    InventoryModel(innerID: Int(innerID), count: Int(count))
  }
}
