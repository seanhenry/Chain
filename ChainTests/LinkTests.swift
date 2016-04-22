//
//  LinkTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class LinkTests: XCTestCase {

    var link: Link<String, Int>!
    var partiallyMockedLink: PartialMockLink<String, Int>!
    var mockedNext: MockLink<Int, String>!
    
    override func setUp() {
        super.setUp()
        link = Link()
        partiallyMockedLink = PartialMockLink()
        mockedNext = MockLink()
        link.next = mockedNext
    }

    // MARK: - result

    func test_result_shouldBeNoResultTypeError() {
        let link = Link<String, String>()
        XCTAssertEqual(link.result.error as? ChainError, .NoResultValue)
    }
    
    // MARK: - finish
    
    func test_finish_shouldSetNextInitialValueToResultValue() {
        link.result = .Success(123)
        finish()
        XCTAssertTrue(mockedNext.initial.isSuccessWithResult(link.result.result))
    }

    func test_finish_shouldRunNextLink() {
        finish()
        XCTAssertTrue(mockedNext.didCallRun)
    }

    // MARK: - Helpers

    func callRun() {
        partiallyMockedLink.run()
    }

    func finish() {
        link.finish()
    }
}

class PartialMockLink<InitialType, ResultType>: Link<InitialType, ResultType> {

    var didCallMain = false
    override func run() {
        didCallMain = true
        finish()
    }

    var didCallFinish = false
    override func finish() {
        didCallFinish = true
    }
}

class MockLink<InitialType, ResultType>: Link<InitialType, ResultType> {

    var didCallRun = false
    override func run() {
        didCallRun = true
    }
}
