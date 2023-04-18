import SwiftUI

/// Экран загрузки приложения
struct LoadingScreen: View {
  
  var body: some View {
    
    ProgressView()
    
      .navigationBarBackButtonHidden()
    
    // Проверка на то, первый ли запуск приложения
    // Если первый, то загружаем данные с Gist Github
      .task {
        if UserDefaults.standard.bool(forKey: "launchedBefore") != false {
          eventSubject.send(.changeRoute(.replaceTo(.content)))
        } else {
          await prePopulate()
          await loadHeroFromUserDefaults()
          
          UserDefaults.standard.set(true, forKey: "launchedBefore")
          
          // Убираем из стека экран загрузки и заменяем его на ContentView
          eventSubject.send(.changeRoute(.replaceTo(.content)))
        }
      }
  }
  
}


// MARK: - Methods

extension LoadingScreen {
  
  @MainActor private func prePopulate() async {
    
    let locationsRequest: URLRequest = {
      let locationsURLString = InfoPlistManager.shared.values()!["locationsURL"]
      let url = URL(string: locationsURLString as! String)!
      return URLRequest(url: url)
    }()
    
    let monstersRequest: URLRequest = {
      let monstersURLString = InfoPlistManager.shared.values()!["monstersURL"]
      let url = URL(string: monstersURLString as! String)!
      return URLRequest(url: url)
    }()
    
    let itemsRequest: URLRequest = {
      let itemsURLString = InfoPlistManager.shared.values()!["itemsURL"]
      let url = URL(string: itemsURLString as! String)!
      return URLRequest(url: url)
    }()
    
    async let prepopulatedLocations = try await NetworkManager.shared.fetch(type: [LocationModel].self, with: locationsRequest)
    async let prepopulatedMonsters  = try await NetworkManager.shared.fetch(type: [MonsterModel].self, with: monstersRequest)
    async let prepopulatedItems     = try await NetworkManager.shared.fetch(type: [ItemModel].self, with: itemsRequest)
    
    do {
      try await CoreDataManager.shared.prePopulate(
        prepopulatedLocations, prepopulatedMonsters, prepopulatedItems
      )
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func loadHeroFromUserDefaults() async {
    
    let userDefaults = UserDefaults.standard
    
    if let hero = userDefaults.object(forKey: "Hero") as? Data {
      let decoder = JSONDecoder()
      
      if let loadedHero = try? decoder.decode(HeroModel.self, from: hero) {
        heroSubject.send(loadedHero)
      }
      
    } else {
      
      let encoder = JSONEncoder()
      
      let initialHero = HeroModel(name: "Initial Hero")
      
      if let encodedHero = try? encoder.encode(initialHero) {
        userDefaults.set(encodedHero, forKey: "Hero")
      }
    }
  }
}
