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

    // MARK: - run

    func test_run_shouldCallRun() {
        callRun()
        XCTAssertTrue(partiallyMockedLink.didCallMain)
    }

    func test_run_shouldCallFinish_whenDone() {
        callRun()
        partiallyMockedLink.done?()
        XCTAssertTrue(partiallyMockedLink.didCallFinish)
    }

    func test_run_shouldNotCallFinish_whenDoneIsNotCalled() {
        callRun()
        XCTAssertFalse(partiallyMockedLink.didCallFinish)
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
    var done: (() -> ())?
    override func run(done: () -> ()) {
        didCallMain = true
        self.done = done
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
