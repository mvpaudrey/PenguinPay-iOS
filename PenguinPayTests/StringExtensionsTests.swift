//
//  StringExtensionsTests.swift
//  PenguinPayTests
//
//  Created by Audrey SOBGOU ZEBAZE on 24/06/2021.
//

import XCTest
@testable import PenguinPay

class StringExtensionsTests: XCTestCase {

    func testStringTrim() {
        let sut1 = "trimmingString "
        let expectedResult = "trimmingString"

        XCTAssertEqual(sut1.trim(), expectedResult)

        let sut2 = " trimmingString "
        XCTAssertEqual(sut2.trim(), expectedResult)

        let sut3 = " trimming String "
        let expectedResult2 = "trimming String"
        XCTAssertEqual(sut3.trim(), expectedResult2)
    }

    func testStringIsEmpty() {
        let sut1 = ""
        let sut2 = "hey"

        XCTAssertTrue(sut1.isEmpty)
        XCTAssertFalse(sut2.isEmpty)
    }

    func testStringIsNumeric() {
        let sut1: String = "123"
        let sut2: String = "Hey"
        let sut3: String = "123hueys"

        XCTAssertTrue(sut1.isNumeric)
        XCTAssertFalse(sut2.isNumeric)
        XCTAssertFalse(sut3.isNumeric)
    }

    func testStringAsBinaryInt() {
        let sut1: String = "123"
        let sut2: String = " 11"

        XCTAssertNil(sut1.asBinaryInt)
        XCTAssertEqual(sut2.asBinaryInt, 3)

    }

    func testOptionalStringIsNilOrEmpty() {
        let sut1: String? = "hello"
        let sut2: String? = ""
        let sut3: String? = nil

        XCTAssertFalse(sut1.isNilOrEmpty)
        XCTAssertTrue(sut2.isNilOrEmpty)
        XCTAssertTrue(sut3.isNilOrEmpty)
    }

}
