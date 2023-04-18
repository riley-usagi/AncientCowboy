import SwiftUI

extension FightScreen {
  
  var isLoading: some View {
    
    ProgressView()
    
      .task {
        self.hero       = heroSubject.value
        self.monsters   = await MonsterModel.monstersFrom(heroSubject.value.currentLocation)
        
        if let selectedEnemy = monsters.randomElement() {
          self.enemy      = selectedEnemy
          self.maxEnemyHp = selectedEnemy.hp
        } else {
          eventSubject.send(.locationCleared)
        }
        
        TimerManager.runTimer(.fight)
        
        self.viewState = .loaded
      }
  }
}
