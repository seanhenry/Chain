//
//  BlockLinkTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class BlockLinkTests: XCTestCase {

    var didCallBlock = false
    var didCallDone = false
    var block: ((Result<String, ErrorType>) -> ())!
    var link: BlockLink<String>!

    override func setUp() {
        super.setUp()
        didCallBlock = false
        didCallDone = false
        block = { string in
            self.didCallBlock = true
        }
        link = BlockLink<String>(block: block)
        link.initial = .Success("howdy")
    }
    
    // MARK: - main
    
    func test_main_shouldCallBlock() {
        callRun()
        XCTAssertTrue(didCallBlock)
    }

    func test_main_shouldCallFinish() {
        let mockedLink = MockBlockLink(block: block)
        link = mockedLink
        callRun()
        XCTAssertTrue(mockedLink.didCallFinish)
    }

    // MARK: - Helpers

    func callRun() {
        link.run()
    }

    class MockBlockLink: BlockLink<String> {
        override init(block: (Result<String, ErrorType>) -> ()) {
            super.init(block: block)
        }
        var didCallFinish = false
        override func finish() {
            didCallFinish = true
        }
    }
}
