// MARK: - Протоколы работы с Моделями и их версиями из CoreData

protocol ToSafeObject {
  associatedtype SafeType
  func safeObject() throws -> SafeType
}

protocol ToUnSafeObject {
  associatedtype UnSafeType
  func unSafeObject() throws -> UnSafeType
}
