import CoreData
import Foundation

@objc(LocationCD) public class LocationCD: NSManagedObject, Identifiable {
  
  @NSManaged public var name: String
  @NSManaged public var monsters: NSDictionary
}


// MARK: - Methods

extension LocationCD {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationCD> {
    return NSFetchRequest<LocationCD>(entityName: "LocationCD")
  }
}
