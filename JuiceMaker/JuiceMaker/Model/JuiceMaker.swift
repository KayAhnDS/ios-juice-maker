//  JuiceMaker - JuiceMaker.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved

import Foundation

struct JuiceMaker {
    let fruitStore = FruitStore()
    
    func makeJuice(_ juice: Juice) -> Bool {
        do {
            _ = try fruitStore.makeReady(for: juice)
            subtractFruitQuantity(for: juice)
            return true
        } catch (let fruit) {
            print("\(fruit)")
            return false
        }
    }
    
    private func subtractFruitQuantity(for juice: Juice) {
        juice.recipe.forEach { (fruit: Juice.Fruit, count: Int) in
            fruitStore.changeFruitQuantity(by: fruit, count: count)
        }
    }
}
