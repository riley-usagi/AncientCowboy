import SwiftUI

struct HeroScreen: View {
  
  
  // MARK: - Parameters
  
  /// Текущий Action экрана
  @Action(InnerAction.initial) var action
  
  /// Текущее состояние экрана
  @State var viewState: ViewStateEnum = .initial
  
  /// Объект Героя
  @State var hero: HeroModel          = .stub
  
  
  // MARK: - Body
  
  var body: some View {
    content
      .onReceive($action) { newAction in
        switch newAction {
          
        case let .changeStateTo(newState):
          viewState = newState
          
        default:
          break
        }
      }
  }
}


// MARK: - Content

extension HeroScreen {
  
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


// MARK: - Initial

extension HeroScreen {
  var initial: some View {
    Text("")
      .task { viewState = .isLoading }
  }
}


// MARK: - Loading

extension HeroScreen {
  var isLoading: some View {
    ProgressView()
      .task { viewState = .loaded }
  }
}


// MARK: - Loaded

extension HeroScreen {
  var loaded: some View {
    VStack {
      HStack {
        Text("EXP:")
        Spacer()
        Text("\(hero.exp)")
      }
      
      Spacer()
    }
    .padding()
    
  }
}


// MARK: - Actions

extension HeroScreen {
  enum InnerAction: ViewAction {
    static var `default`: HeroScreen.InnerAction { .initial }
    
    case initial
    case changeStateTo(ViewStateEnum)
  }
}
