import Combine
import SwiftUI


/// Обёртка для подписки на События и преобразования их в Действиях на экранах
@propertyWrapper public struct Action<T> {
  
  private let currentValue: CurrentValueSubject<T, Never>
  
  init(_ receivedValue: T) {
    
    self.currentValue = CurrentValueSubject(receivedValue)
    
    _ = eventSubject
    
      .flatMap { receivedEvent -> AnyPublisher<InnerViewAction, Never> in
        return EventEnum.actionsByEvent(receivedEvent).publisher.eraseToAnyPublisher()
      }
      
      .compactMap { receivedAction in
        return receivedAction as? T
      }
      
      .receive(on: DispatchQueue.main)
    
      .subscribe(on: DispatchQueue.main)
      
      .assign(to: \.wrappedValue, on: self)
  }
  
  public var wrappedValue: T {
    get { currentValue.value }
    
    nonmutating set {
      currentValue.value = newValue
    }
  }
  
  public var projectedValue: AnyPublisher<T, Never> {
    get {
      currentValue
        .compactMap({ $0 })
        .eraseToAnyPublisher()
    }
  }
}
