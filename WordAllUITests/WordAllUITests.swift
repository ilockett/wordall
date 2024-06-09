//
//  WordAllUITests.swift
//  WordAllUITests
//
//  Created by Ian Lockett on 05/06/2024.
//

import XCTest

final class WordAllUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("UITEST")
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_randomWordView_displaysHello() throws {
        XCTAssert(app.staticTexts["tiled-word-view"].waitForExistence(timeout: 5))
        let tiledWordView = app.staticTexts["tiled-word-view"]
        XCTAssertEqual(tiledWordView.label, "hello")
    }

    func test_wordDefinitionView_displaysDefinition() throws {
        XCTAssert(app.buttons["randomword.button.moreinfo"].waitForExistence(timeout: 5))
        app.buttons["randomword.button.moreinfo"].tap()

        XCTAssert(app.staticTexts["worddefinition.text.definition"].waitForExistence(timeout: 2))

        let definitionText = app.staticTexts["worddefinition.text.definition"]
        XCTAssertEqual(definitionText.label, "an expression of greeting")
    }

}
