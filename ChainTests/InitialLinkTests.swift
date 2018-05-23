//
//  InitialLinkTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class InitialLinkTests: XCTestCase {
    
    var link: InitialLink<String>!
    
    override func setUp() {
        super.setUp()
        link = InitialLink()
    }
    
    // MARK: - initial

    func test_initial_shouldBeNoInitialTypeError() {
        XCTAssertEqual(link.initial.error as? ChainError, .noInitialValue)
    }

    // MARK: - initialValue

    func test_initialValue() {
        link.initial = .success("initial")
        XCTAssertEqual(link.initialValue, "initial")
    }

    func test_initialValue_shouldReturnNil_whenInitialIsError() {
        XCTAssertNil(link.initialValue)
    }
}
