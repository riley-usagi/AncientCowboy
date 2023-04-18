import CoreData
import SwiftUI

/// Менеджер для работы с CoreData
class CoreDataManager {
  
  static let shared = CoreDataManager()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    
    container = NSPersistentContainer(name: "DataBase")
    
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    
    //    for description in container.persistentStoreDescriptions {
    //      print(description.url!)
    //    }
  }
}


// MARK: - CRUD

extension CoreDataManager {
  
  
  // MARK: - Create
  
  func create<R>(_ models: [R]) async throws where R: ToUnSafeObject {
    for item in models {
      _ = try item.unSafeObject()
    }
    
    do {
      try container.viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
  
  
  // MARK: - Read
  
  func read<E, R>(request: NSFetchRequest<E>) async throws -> [R] where E: NSManagedObject, E: ToSafeObject, R == E.SafeType {
    try await self.container.viewContext.perform {
      try self.container.viewContext.fetch(request).compactMap { try $0.safeObject() }
    }
  }
}


// MARK: - Helpers

extension CoreDataManager {
  
  
  // MARK: - Reset
  
  func resetAllCoreData() {
    
    // get all entities and loop over them
    let entityNames = container.managedObjectModel.entities.map({ $0.name!})
    
    entityNames.forEach { entityName in
      let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
      
      do {
        try container.viewContext.execute(deleteRequest)
        try container.viewContext.save()
      } catch {
        // error
        print(error.localizedDescription)
      }
    }
  }
  
  
  // MARK: - PrePopulate
  
  func prePopulate(_ locations: [LocationModel], _ monsters: [MonsterModel], _ items: [ItemModel]) {
    
    let viewContext = container.viewContext
    
    for location in locations {
      let locationCD = LocationCD(context: viewContext)
      
      locationCD.name     = location.name
      locationCD.monsters = location.monsters as NSDictionary
    }
    
    for monster in monsters {
      
      let monsterCD = MonsterCD(context: viewContext)
      
      monsterCD.id       = UUID()
      monsterCD.name     = monster.name
      monsterCD.innerID  = Int32(monster.innerID)
      monsterCD.atk1     = Int32(monster.atk1)
      monsterCD.hp       = Int32(monster.hp)
      monsterCD.drop1id  = Int32(monster.drop1id)
      monsterCD.drop1per = Int32(monster.drop1per)
    }
    
    for item in items {
      
      let itemCD = ItemCD(context: viewContext)
      
      itemCD.id      = UUID()
      itemCD.innerID = Int32(item.innerID)
      itemCD.name    = item.name
    }
    
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
}
