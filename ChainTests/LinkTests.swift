//
//  LinkTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class LinkTests: XCTestCase {

    var link: Link<String, Int>!
    var mockedNext: MockLink<Int, String>!
    
    override func setUp() {
        super.setUp()
        link = Link()
        mockedNext = MockLink()
        link.next = mockedNext
    }

    // MARK: - result

    func test_result_shouldBeNoResultTypeError() {
        let link = Link<String, String>()
        XCTAssertEqual(link.result.error as? ChainError, .NoResultValue)
    }

    // MARK: - finish(result:)

    func test_finishResult_shouldPassResult() {
        finish(result: 123)
        XCTAssertTrue(mockedNext.initial.isSuccessWithResult(123))
    }

    func test_finishResult_shouldRunNext() {
        finish(result: 456)
        XCTAssertTrue(mockedNext.didCallRun)
    }
    
    // MARK: - finish(error:)
    
    func test_finishError_shouldPassError() {
        finish(error: TestError.Some)
        XCTAssertEqual(mockedNext.initial.error as? TestError, TestError.Some)
    }

    func test_finishError_shouldFinishNextWithError() {
        finish(error: TestError.Some)
        XCTAssertTrue(mockedNext.didCallFinishWithError)
    }

    // MARK: - Helpers

    func finish(result result: Int) {
        link.finish(result: result)
    }

    func finish(error error: ErrorType) {
        link.finish(error: error)
    }
}
