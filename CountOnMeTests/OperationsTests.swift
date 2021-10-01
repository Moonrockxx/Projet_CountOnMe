//
//  OperationsTests.swift
//  CountOnMeTests
//
//  Created by TomF on 15/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class OperationsTests: XCTestCase {

    var operations: Operations!
    
    override func setUp() {
        super.setUp()
        operations = Operations()
    }

    func testGivenOperationsHasOne_WhenTwoIsAdded_ThenWeGetThree() {
        operations.addNumber("1")
        operations.addOperator("+")
        operations.addNumber("2")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "1 + 2 = 3.0")
    }
    
    func testGivenOprationsHasTwo_WhenOneIsSubstracted_ThenWeGetOne() {
        operations.addNumber("2")
        operations.addOperator("-")
        operations.addNumber("1")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "2 - 1 = 1.0")
    }
    
    func testGivenOperationsHasThree_WhenMultipliedByThree_ThenWeGetNine() {
        operations.addNumber("3")
        operations.addOperator("x")
        operations.addNumber("3")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "3 x 3 = 9.0")
    }
    
    func testGivenOperationsHasTen_WhenDividedByTwo_ThenWeGetFive() {
        operations.addNumber("10")
        operations.addOperator("/")
        operations.addNumber("2")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "10 / 2 = 5.0")
    }
    
    func testPrio() {
        operations.addNumber("10")
        operations.addOperator("/")
        operations.addNumber("2")
        operations.addOperator("+")
        operations.addNumber("2")
        operations.addOperator("x")
        operations.addNumber("3")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "10 / 2 + 2 x 3 = 11.0")
    }
    
    func testGivenWeHaveAResult_WhenAllClearIsCalled_ThenStringOperationsIsEmpty() {
        operations.addNumber("1")
        operations.addOperator("+")
        operations.addNumber("2")
        operations.equalTapped()
        operations.allClear()
        XCTAssertEqual(operations.stringOperations, "")
    }
    
    func testGivenWeHaveADivisionByZero_WhenEqualIsCalled_ThenHasDivisionByZeroPropertyBecomesTrue() {
        operations.addNumber("1")
        operations.addOperator("/")
        operations.addNumber("0")
        operations.equalTapped()
        XCTAssertEqual(operations.hasDivisionByZero, true)
    }
    
    func testGivenOperationsHasOne_WhenTwoConsecutiveOperatorsAreAdded_ThenExpressionIsCorrectBecomeFalse() {
        operations.addNumber("1")
        operations.addOperator("+")
        operations.addOperator("+")
        operations.equalTapped()
        XCTAssertEqual(operations.expressionIsCorrect, false)
    }
    
    func testGivenWeAddOneNumberToAnother_WhenEqualIsCalled_ThenTheExpressionHasEnoughElements() {
        operations.addNumber("1")
        operations.addNumber("1")
        operations.equalTapped()
        XCTAssertEqual(operations.expressionHaveEnoughElement, false)
    }
    
    func testGivenStringOperations() {
        operations.addOperator("+")
        XCTAssertEqual(operations.expressionIsEmpty, true)
    }
}
