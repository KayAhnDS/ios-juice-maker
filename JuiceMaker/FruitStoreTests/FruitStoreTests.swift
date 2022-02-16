//
//  FruitStoreTests.swift
//  FruitStoreTests
//
//  Created by Ryan-Son on 2022/02/15.
//

import XCTest
@testable import JuiceMaker

class FruitStoreTests: XCTestCase {

    private var sut: FruitStoreType?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FruitStore(initialValue: 0)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_add를_통해_지정한_수만큼_과일_수량을_추가할_수_있다() throws {
        let expectedCount = 1
        sut?.setAmount(for: .strawberry, to: 1)
        
        XCTAssertEqual(sut?.count(of: .strawberry) , expectedCount)
    }
    
    func test_consume을_통해_지정한_수만큼_과일_수량을_감소시킬_수_있다() throws {
        let initialFruitCount = 10
        let expectedStrawberryCount = 7
        let expectedMangoCount = 8
        let expectedKiwiCount = 4
        sut?.setAmount(for: .strawberry, to: initialFruitCount)
        sut?.setAmount(for: .mango, to: initialFruitCount)
        sut?.setAmount(for: .kiwi, to: initialFruitCount)

        let fruits: Fruits = [.strawberry: 3, .mango: 2, .kiwi: 6]
        sut?.consume(ingredients: fruits)
        
        XCTAssertEqual(sut?.count(of: .strawberry), expectedStrawberryCount)
        XCTAssertEqual(sut?.count(of: .mango), expectedMangoCount)
        XCTAssertEqual(sut?.count(of: .kiwi), expectedKiwiCount)
    }

    func test_과일_종류_배열을_초기값을_가진_배열_형태로_변환할_수_있다() {
        let initialValue = 10
        var expected: Fruits = [:]
        Fruit.allCases.forEach { fruit in
            expected[fruit] = initialValue
        }
        
        let result = Fruit.allCases.toFruits(with: initialValue)

        XCTAssertEqual(result, expected)
    }
    
    func test_과일의_재고가_필요량보다_적은경우_false를_반환한다() {
        let hasIngredients = sut?.hasIngredients(for: .strawberry)

        XCTAssertEqual(hasIngredients, false)
    }
    
    func test_과일의_재고가_필요량을_충족할_경우_true를_반환한다() {
        guard let required = Juice.mango.ingredients[.mango] else {
            XCTFail("망고쥬스의 필요량이 정의되어있지 않습니다.")
            return
        }
        sut?.setAmount(for: .mango, to: required)

        let hasIngredients = sut?.hasIngredients(for: .mango)
        
        XCTAssertEqual(hasIngredients, true)
    }
}
