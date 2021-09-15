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

    func testAddition() {
        operations.addNumber("1")
        operations.addOperator("+")
        operations.addNumber("2")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "1 + 2 = 3.0")
    }
    
    func testSoustraction() {
        operations.addNumber("2")
        operations.addOperator("-")
        operations.addNumber("1")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "2 - 1 = 1.0")
    }
    
    func testMultiplication() {
        operations.addNumber("3")
        operations.addOperator("x")
        operations.addNumber("3")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "3 x 3 = 9.0")
    }
    
    func testDivision() {
        operations.addNumber("10")
        operations.addOperator("/")
        operations.addNumber("2")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "10 / 2 = 5.0")
    }
    
    func testConsecutiveOperators() {
        operations.addNumber("1")
        operations.addOperator("+")
        operations.addOperator("+")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "1 + ")
    }
    
    func testEnoughElements() {
        operations.addNumber("111")
        operations.equalTapped()
        XCTAssertEqual(operations.stringOperations, "111")
    }
    
    func testResetWorks() {
        operations.addNumber("1")
        operations.addOperator("+")
        operations.addNumber("2")
        operations.equalTapped()
        operations.allClear()
        XCTAssertEqual(operations.stringOperations, "")
    }
    
    func testDivisionByZero() {
        operations.addNumber("1")
        operations.addOperator("/")
        operations.addNumber("0")
        operations.equalTapped()
        XCTAssert(operations.hasDivisionByZero)
    }
}
