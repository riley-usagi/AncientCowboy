import CoreData
import Foundation

@objc(ItemCD) public class ItemCD: NSManagedObject, Identifiable {
  
  
  // MARK: - Parameters
  
  @NSManaged public var id: UUID
  @NSManaged public var innerID: Int32
  @NSManaged public var name: String
}


// MARK: - Methods

extension ItemCD {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemCD> {
    return NSFetchRequest<ItemCD>(entityName: "ItemCD")
  }
}

extension ItemCD: ToSafeObject {
  func safeObject() throws -> ItemModel {
    return ItemModel(innerID: Int(innerID), name: name)
  }
}
