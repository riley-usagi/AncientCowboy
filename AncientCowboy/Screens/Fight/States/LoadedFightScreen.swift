import SwiftUI

extension FightScreen {
  
  var loaded: some View {
    
    VStack {
      
      // Hero
      VStack {
        HStack {
          Text(hero.name).font(.title)
          Text(": \(hero.hp) HP").font(.subheadline)
        }
      }
      
      // Enemy
      VStack {
        Gauge(value: Double(enemy.hp), in: 0...Double(maxEnemyHp)) {
          HStack {
            Text("\(enemy.name)")
            Text(": \(enemy.hp) HP").font(.subheadline)
          }
        }
      }
      
      VStack {
        Text("Monsters on location left: \(monsters.count)").font(.headline)
      }
    }
    .padding()
    
    .onReceive(TimerManager.heroAttackTimer) { _ in
      
      if enemy.hp > 0 && hero.atk <= enemy.hp {
      
        enemy.hp -= hero.atk
        
      } else {
        
        Task {
          await InventoryModel.getDropFrom(enemy)
        }
        
        if let index = monsters.firstIndex(where: { $0.id == enemy.id }) {
          monsters.remove(at: index)
        }
        
        if let newEnemy = monsters.randomElement() {
          self.enemy      = newEnemy
          self.maxEnemyHp = newEnemy.hp
        } else {
          eventSubject.send(.locationCleared)
        }
      }
    }
  }
}
