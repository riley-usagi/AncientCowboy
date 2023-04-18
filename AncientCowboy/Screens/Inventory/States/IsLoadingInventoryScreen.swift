import SwiftUI

extension InventoryScreen {
  var isLoading: some View {
    ProgressView()
      .task {
        inventoryItems  = await InventoryModel.all()
        viewState       = .loaded
      }
  }
}
