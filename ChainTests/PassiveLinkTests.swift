//
//  PassiveLinkTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class PassiveLinkTests: XCTestCase {
    
    var link: PassiveLink<String>!
    var mockedNext: MockLink<String, String>!
    
    override func setUp() {
        super.setUp()
        mockedNext = MockLink()
        link = PassiveLink()
        link.next = mockedNext
    }
    
    // MARK: - initial
    
    func test_initial_shouldSetResult() {
        link.initial = .Success("some")
        XCTAssertTrue(link.result.isSuccess(with: link.initial.result))
    }

    // MARK: - finish

    func test_finish_shouldSetInitialOnNext() {
        link.initial = .Success("hurrah")
        link.finish()
        XCTAssertTrue(link.next!.initial.isSuccess(with: link.result.result))
    }

    func test_finish_shouldRunNext() {
        link.finish()
        XCTAssertTrue(mockedNext.didCallRun)
    }

    func test_finish_shouldSetPreviousToNil() {
        link.previous = link
        link.finish()
        XCTAssertNil(link.previous)
    }
}
