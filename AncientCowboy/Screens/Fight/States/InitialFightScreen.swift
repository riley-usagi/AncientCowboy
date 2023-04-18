import SwiftUI

extension FightScreen {
  var initial: some View {
    Text("")
      .onAppear { viewState = .isLoading }
  }
}
