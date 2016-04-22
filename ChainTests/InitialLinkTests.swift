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
        XCTAssertEqual(link.initial.error as? ChainError, .NoInitialValue)
    }

    // MARK: - run

    func test_run_shouldCallRun_thenFinish() {
        let mockedLink = MockInitialLink()
        mockedLink.run()
        XCTAssertTrue(mockedLink.didCallRun)
        XCTAssertTrue(mockedLink.didCallFinish)
    }

    // MARK: - Helpers

    class MockInitialLink: InitialLink<String> {
        var didCallRun = false
        override func run(done: () -> ()) {
            didCallRun = true
            done()
        }
        var didCallFinish = false
        override func finish() {
            didCallFinish = true
        }
    }
}
