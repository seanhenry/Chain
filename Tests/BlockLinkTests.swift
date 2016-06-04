//
//  BlockLinkTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class BlockLinkTests: XCTestCase {

    var didCallBlock = false
    var blockResult: ChainResult<String, ErrorProtocol>?
    var didCallDone = false
    var block: ((ChainResult<String, ErrorProtocol>) -> ())!
    var link: BlockLink<String>!

    override func setUp() {
        super.setUp()
        didCallBlock = false
        didCallDone = false
        block = { result in
            self.blockResult = result
            self.didCallBlock = true
        }
        link = BlockLink<String>(block: block)
        link.initial = .Success("howdy")
    }
    
    // MARK: - run
    
    func test_run_shouldCallBlock() {
        callRun()
        XCTAssertTrue(didCallBlock)
    }

    // MARK: - finish(error:)

    func test_finishError_shouldCallBlockWithError() {
        link.finish(error: TestError.Some)
        XCTAssertTrue(didCallBlock)
        XCTAssertEqual(blockResult?.error as? TestError, TestError.Some)
    }

    // MARK: - Helpers

    func callRun() {
        link.run()
    }
}
