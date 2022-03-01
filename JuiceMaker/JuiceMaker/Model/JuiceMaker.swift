//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

// 쥬스 메이커 타입
struct JuiceMaker {
    func makeJuice(fruitJuice: JuiceTypes, fruitStore: FruitStore) -> [JuiceTypes:Int] {
        var resultNumber = Dictionary<JuiceTypes, Int>()
        let recipe = fruitJuice.recipe
        do  {
            resultNumber = try fruitStore.consumeFruit(recipe: recipe)
        } catch JuiceMakerError.outOfStock {
            print("재고가 없습니다")
        } catch {
            print("예상치 못한 에러 발생")
        }
        return resultNumber
    }
}
