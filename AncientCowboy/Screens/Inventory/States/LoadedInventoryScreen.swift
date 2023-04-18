import AiDesign
import SwiftUI

extension InventoryScreen {
  
  var loaded: some View {
    
    LazyVStack {
      ForEach(inventoryItems, id: \.id) { item in
        VStack {
          HStack {
            Text("InnerID: \(item.innerID)")
              .typography(.h1Bold)
            Spacer()
            Text("Count: \(item.count)")
              .typography(.h2Regular)
          }
          .padding()
          Text("\(item.id)")
        }
      }
    }
    .listStyle(PlainListStyle())
    
  }
}
