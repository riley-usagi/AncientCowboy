import SwiftUI

/// Основной экран битвы героя с монстрами на локации
struct FightScreen: View {
  
  
  // MARK: - Parameters
  
  @Action(InnerAction.initial) var action
  @State var viewState: ViewStateEnum = .initial
  @State var monsters: [MonsterModel] = []
  @State var hero: HeroModel          = .stub
  @State var enemy: MonsterModel      = .stub
  @State var maxEnemyHp: Int          = 1000
  
  
  // MARK: - Body
  
  var body: some View {
    content
      .onReceive($action) { receivedAction in
        
        switch receivedAction {
          
        case .initial:
          break
          
        case let .changeStateTo(newState):
          viewState = newState
        }
      }
  }
}


// MARK: - Content

extension FightScreen {
  
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

extension FightScreen {
  enum InnerAction: ViewAction {
    
    static var `default`: FightScreen.InnerAction { .initial }

    case initial
    case changeStateTo(ViewStateEnum)
  }
}
