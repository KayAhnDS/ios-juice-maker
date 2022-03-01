//
//  JuiceMaker - JuiceMaker.swift
//  Created by Vayne, 우롱차.
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

struct JuiceMaker {
    private var recipe: Dictionary<Juice,Dictionary<Fruit,Int>> = Juice.defaultJuiceRecipe
    private let fruitStore: FruitStore
    
    static let juiceMaker = JuiceMaker(fruitStore: FruitStore.fruitStore)
    
    init(fruitStore: FruitStore) {
        self.fruitStore = fruitStore
    }
    
    func getAJuiceRecipe(juice: Juice) throws -> Dictionary<Fruit,Int> {
        guard let juiceRecipe = self.recipe[juice] else {
            throw JuiceMakingError.noRecipe
        }
        return juiceRecipe
    }
    
    func makeJuice(_ juice: Juice) -> Juice? {
        do {
            let juiceRecipe = try getAJuiceRecipe(juice: juice)
            for (fruit,amount) in juiceRecipe {
                try self.fruitStore.checkStock(fruit: fruit, amount: amount)
            }
            for (fruit,amount) in juiceRecipe {
                try self.fruitStore.consumeStock(fruit: fruit, amount: amount)
            }
            return juice
        } catch {
            if let juiceMakingError = error as? JuiceMakingError {
                JuiceMakingError.printErrorMessage(error: juiceMakingError)
            } else {
                JuiceMakingError.printErrorMessage(error: JuiceMakingError.unkownError)
            }
            return nil
        }
    }
}
