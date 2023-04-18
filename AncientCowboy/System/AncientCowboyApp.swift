import Combine
import SwiftUI

/// Точка входа в приложение
@main struct AncientCowboyApp: App {
  
  @State var path: [RouteEnum] = [.loading]
  
  var body: some Scene {
    
    WindowGroup {
      
      NavigationStack(path: $path) {
        
        Text("")
        
          .navigationDestination(for: RouteEnum.self) { route in
            
            switch route {
              
            case .loading:
              LoadingScreen()
              
            case .content:
              ContentView()
            }
          }
        
          .onReceive(eventSubject) { event in
            
            if case let EventEnum.changeRoute(routingAction) = event {
              switch routingAction {
              case .back:
                path.removeLast()
              case .backToRoot:
                path.removeAll()
                path.append(.content)
              case let .goTo(route):
                path.append(route)
              case let .replaceTo(route):
                path.append(route)
                path.remove(at: path.count - 2)
              }
            }
          }
      } 
    }
  }
}
