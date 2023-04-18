import SwiftUI

struct ContentView: View {
  
  @State var tabSelected: TabItem = .fight
  
  var body: some View {
    
    TabView(selection: $tabSelected) {
      FightScreen()
        .tag(TabItem.fight)
        .tabItem {
          Image(systemName: "house")
          Text("Fight")
        }
      
      InventoryScreen()
        .tag(TabItem.inventory)
        .tabItem {
          Image(systemName: "square.grid.3x3.square")
          Text("Inventory")
        }
      
      SettingsScreen()
        .tag(TabItem.settings)
        .tabItem {
          Image(systemName: "gear")
          Text("Settings")
        }
    }
    .navigationBarBackButtonHidden()
    
  }
}

extension ContentView {
  enum TabItem: Equatable {
    case fight
    case inventory
    case settings
  }
}
