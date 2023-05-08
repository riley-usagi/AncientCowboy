import SwiftUI

extension InventoryScreen {
  
  var loaded: some View {
    
    LazyVStack {
      ForEach(inventoryItems, id: \.id) { item in
        VStack {
          HStack {
            Text("InnerID: \(item.innerID)")
            Spacer()
            Text("Count: \(item.count)")
          }
          .padding()
        }
      }
    }
    .listStyle(PlainListStyle())
    
  }
}
