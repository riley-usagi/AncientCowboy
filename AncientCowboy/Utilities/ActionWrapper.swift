import Combine
import SwiftUI

@propertyWrapper struct Action<T: InnerViewAction> {
  
  private let currentValue: CurrentValueSubject<T, Never>
  
  init(_ receivedValue: T) {
    
    self.currentValue = CurrentValueSubject(receivedValue)
    
    _ = eventSubject
    
      .flatMap { receivedEvent -> AnyPublisher<any InnerViewAction, Never> in
        return EventEnum.actionsByEvent(receivedEvent).publisher.eraseToAnyPublisher()
      }
    
      .compactMap { receivedAction in
        return receivedAction as? T
      }
    
      .subscribe(on: DispatchQueue.main)
    
      .assign(to: \.wrappedValue, on: self)
  }
  
  public var wrappedValue: T {
    get { currentValue.value }
    
    nonmutating set {
      currentValue.value = newValue
      currentValue.value = T.default
    }
  }
  
  public var projectedValue: AnyPublisher<T, Never> {
    get {
      currentValue
        .compactMap({ $0 })
        .drop { $0 == T.default }
        .eraseToAnyPublisher()
    }
  }
}
