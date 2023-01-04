//
//  RichTextViewUITests.swift
//  RichTextViewUITests
//
//  Created by Russell on 9/8/22.
//

import XCTest

class RichTextViewUITests: XCTestCase {
    
    func testRichTextViewExists() {
        let app = XCUIApplication()
        app.activate()
        let richTextView = app.otherElements["RichTextView"]
        XCTAssertTrue(richTextView.exists)
    }

    func testTextEntry() throws {
        let app = XCUIApplication()
        app.activate()
        let richTextViewBox = app.textViews["RichTextViewBox"]
        richTextViewBox.tap()
        let testString = "Hello, world"
        richTextViewBox.typeText(testString)
        XCTAssertTrue(richTextViewBox.exists)
        XCTAssertEqual(richTextViewBox.value as! String, testString)
        app.terminate()
    }
    
}
