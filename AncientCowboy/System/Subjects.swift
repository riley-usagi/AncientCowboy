import Combine

/// Объект принимающий и передающий все События в приложении
let eventSubject: CurrentValueSubject<EventEnum, Never> = .init(.initial)

/// Объект с данными о герое
let heroSubject: CurrentValueSubject<HeroModel, Never>  = .init(.current)
