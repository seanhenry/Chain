//
//  ChainTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class ChainTests: XCTestCase {

    var chain: Chain<String, String>!
    var first: MockLink<String, String>!

    override func setUp() {
        super.setUp()
        first = MockLink()
        chain = Chain(first)
    }

    // MARK: - findFirst

    func test_findFirst_shouldReturnCurrentLink_whenSelfIsFirst() {
        XCTAssertTrue(chain.findFirst() === chain.last)
    }

    func test_findFirst_shouldReturnPrevious_whenSelfIsSecond() {
        let chain = self.chain.then(Link<String, String>())
        XCTAssertTrue(chain.findFirst() === first)
    }

    func test_findFirst_shouldReturnFirst_whenSelfIsThird() {
        let chain = self.chain.then(Link<String, String>()).then(Link<String, String>())
        XCTAssertTrue(chain.findFirst() === first)
    }

    // MARK: - finally

    func test_finally_shouldSetRelationshipWithBlockLink() {
        chain.finally { _ in }
        XCTAssertTrue(chain.last.next is BlockLink)
    }

    func test_finally_shouldSetRelationshipWithLink() {
        let link = Link<String, ()>()
        chain.finally(link)
        XCTAssertTrue(chain.last.next === link)
        XCTAssertTrue(link.previous === chain.last)
    }

    // MARK: - Chain
    
    func test_Chain_canLinkStringLinks() {
        let expectation = expectationWithDescription("")
        Chain(TestStringLink()).then(TestStringLink()).finally { result in
            XCTAssertEqual(result.result, "hurrah")
            expectation.fulfill()
        }.run()
        waitForExpectationsWithTimeout(5, handler: nil)
    }

    func test_Chain_canLinkDifferentTypes_andPassiveLinks() {
        let expectation = expectationWithDescription("")
        Chain(IntToString(5)).then(PassString()).finally { result in
            XCTAssertEqual(result.result, "5")
            expectation.fulfill()
        }.run()
        waitForExpectationsWithTimeout(5, handler: nil)
    }

    // MARK: - run

    func test_run_shouldRunFirstLink() {
        let chain = self.chain.then(Link<String, String>()).then(Link<String, String>()).finally { _ in }
        chain.run()
        XCTAssertTrue(first.didCallRun)
    }

    // MARK: - Helpers

    class TestStringLink: Link<String, String> {

        override func run() {
            finish(result: "hurrah")
        }
    }
    
    class IntToString: Link<Int, String> {

        init(_ value: Int) {
            super.init()
            initial = .Success(value)
        }

        override func run() {
            let string = String(initial.result!)
            finish(result: string)
        }
    }

    class PassString: PassiveLink<String> {

        override func run() {
            finish()
        }
    }
}
