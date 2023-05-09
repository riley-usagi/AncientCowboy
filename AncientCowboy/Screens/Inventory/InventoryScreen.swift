import SwiftUI

/// Экран с инвентарём
struct InventoryScreen: View {
  
  
  // MARK: - Parameters
  
  @Action(InnerAction.initial) var action
  @State var viewState: ViewStateEnum = .initial
  @State var inventoryItems: [InventoryModel] = []
  
  
  // MARK: - Body
  
  var body: some View {
    
    content
    
      .onReceive($action) { receivedAction in
        
        switch receivedAction {
          
        case .initial:
          break
          
        case let .changeStateTo(newState):
          viewState = newState
          
        case let .itemDropped(innerID):
          updateInventoryCell(innerID)
        }
      }
  }
}


// MARK: - Content

extension InventoryScreen {
  
  private var content: some View {
    switch viewState {
    case .initial:
      return AnyView(initial)
    case .isLoading:
      return AnyView(isLoading)
    case .loaded:
      return AnyView(loaded)
    case let .failed(error):
      return AnyView(Text(String(describing: error)))
    }
  }
}


// MARK: - Actions

extension InventoryScreen {
  enum InnerAction: ViewAction {
    
    static var `default`: InventoryScreen.InnerAction { .initial }
    
    case initial
    case changeStateTo(ViewStateEnum)
    case itemDropped(innerID: Int)
  }
}


// MARK: - Methods

extension InventoryScreen {
  
  func updateInventoryCell(_ innerID: Int) {
    if let index = inventoryItems.firstIndex(where: { inventoryItem in
      inventoryItem.innerID == innerID
    }) {
      inventoryItems[index] = InventoryModel(innerID: innerID, count: inventoryItems[index].count + 1)
    } else {
      inventoryItems.append(InventoryModel(innerID: innerID))
    }
  }
}
