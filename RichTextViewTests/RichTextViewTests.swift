//
//  RichTextViewTests.swift
//  RichTextViewTests
//
//  Created by Russell on 9/8/22.
//

import XCTest
@testable import RichTextView

class RichTextViewTests: XCTestCase {

    func testEmptyText() throws {
        let richTextView = RichTextView()
        XCTAssertEqual(richTextView.attributedText.string, "")
    }
    
    func testSetSimpleText() throws {
        let richTextView = RichTextView()
        let textString = "Rich Text Here"
        richTextView.setText(textString)
        XCTAssertEqual(richTextView.attributedText.string, textString)
    }
    
    func testSetAttributedText() throws {
        let richTextView = RichTextView()
        let attrString = NSAttributedString(string: "Rich Text Here")
        richTextView.setAttributedString(attrString)
        XCTAssertEqual(richTextView.attributedText, attrString)
    }

    func testBoldAttributedText() throws {
        let richTextView = RichTextView()
        let attrString = NSAttributedString(string: "Rich Text Here", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)])
        richTextView.setAttributedString(attrString)
        XCTAssertEqual(richTextView.attributedText, attrString)
    }
    
    func testItalicAttributedText() throws {
        let richTextView = RichTextView()
        let attrString = NSAttributedString(string: "Rich Text Here", attributes:[NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
        richTextView.setAttributedString(attrString)
        XCTAssertEqual(richTextView.attributedText, attrString)
    }
    
    func testStrikethroughAttributedText() throws {
        let richTextView = RichTextView()
        let attrString = NSAttributedString(string: "Rich Text Here", attributes: [
            NSAttributedString.Key.strikethroughStyle: 1])
        richTextView.setAttributedString(attrString)
        XCTAssertEqual(richTextView.attributedText, attrString)
    }
    
}
