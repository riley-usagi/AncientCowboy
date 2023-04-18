import SwiftUI

extension InventoryScreen {
  var initial: some View {
    Text("")
      .onAppear { viewState = .isLoading }
  }
}
