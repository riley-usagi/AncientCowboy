import CoreData
import Foundation

@objc(MonsterCD) public class MonsterCD: NSManagedObject, Identifiable, ToSafeObject {
  
  
  // MARK: - Parameters
  
  @NSManaged public var id: UUID
  @NSManaged public var innerID: Int32
  @NSManaged public var atk1: Int32
  @NSManaged public var name: String
  @NSManaged public var hp: Int32
  @NSManaged public var drop1id: Int32
  @NSManaged public var drop1per: Int32
}


// MARK: - Methods

extension MonsterCD {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<MonsterCD> {
    return NSFetchRequest<MonsterCD>(entityName: "MonsterCD")
  }
  
  @nonobjc public class func by(id: Int) -> NSFetchRequest<MonsterCD> {
    
    let request         = fetchRequest()
    let predicate       = NSPredicate(format: "innerID == %@", String(id))
    request.predicate   = predicate
    request.fetchLimit  = 1
    
    return request
  }
  
  func safeObject() throws -> MonsterModel {
    MonsterModel(
      innerID: Int(innerID), name: name, atk1: Int(atk1), hp: Int(hp), drop1id: Int(drop1id), drop1per: Int(drop1per)
    )
  }
}
