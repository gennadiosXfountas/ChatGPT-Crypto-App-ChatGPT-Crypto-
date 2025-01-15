//
//  ChatGPT_Crypto_AppTests.swift
//  ChatGPT Crypto AppTests
//
//  Created by Ingo Boehme on 20.03.23.
//


import XCTest

@testable import ChatGPT_Crypto_App // Replace with your project's module name

class CurrencyFormatterTests: XCTestCase {
    let epsilon = 1e-6
    
    func testCurrencyFormatted_zero() {
        let value: Double = 0
        let formatted = value.currencyFormatted()
        XCTAssertEqual(formatted, NumberFormatter.localizedString(from: NSNumber(value: value), number: .currency))
    }

    func testCurrencyFormatted_positiveValue() {
        let value: Double = 1234.56
        let formatted = value.currencyFormatted()
        XCTAssertEqual(formatted, NumberFormatter.localizedString(from: NSNumber(value: value), number: .currency))
    }

    func testCurrencyFormatted_negativeValue() {
        let value: Double = -1234.56
        let formatted = value.currencyFormatted()
        XCTAssertEqual(formatted, NumberFormatter.localizedString(from: NSNumber(value: value), number: .currency))
    }

    func testCurrencyFormatted_largeValue() {
        let value: Double = 1_000_000_000.99
        let formatted = value.currencyFormatted()
        XCTAssertEqual(formatted, NumberFormatter.localizedString(from: NSNumber(value: value), number: .currency))
    }
    
    static var allTests = [
        ("testCurrencyFormatted_zero", testCurrencyFormatted_zero),
        ("testCurrencyFormatted_positiveValue", testCurrencyFormatted_positiveValue),
        ("testCurrencyFormatted_negativeValue", testCurrencyFormatted_negativeValue),
        ("testCurrencyFormatted_largeValue", testCurrencyFormatted_largeValue)
    ]
}
