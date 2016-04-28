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

    // MARK: - init(link:initialValue:)

    func test_init_shouldPassInitialValue() {
        let chain = Chain(initialValue: "testing", first)
        XCTAssertEqual(chain.last.initialValue, "testing")
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

    func test_Chain_persistsDuringAsyncOperations() {
        let e = expectationWithDescription("")
        weak var _ = Chain(PassString()).then(Async()).finally { _ in
            e.fulfill()
        }.run()
        waitForExpectationsWithTimeout(5, handler: nil)
    }

    func test_Chain_withPassiveLink_diesOnceOperationsHaveFinished() {
        var strongLink: PassString? = PassString()
        weak var weakLink = strongLink
        Chain(strongLink!).then(PassString()).finally { _ in }.run()
        strongLink = nil
        XCTAssertNil(weakLink)
    }

    func test_Chain_withSuccessfulLink_diesOnceOperationsHaveFinished() {
        var strongLink: PassString? = PassString()
        weak var weakLink = strongLink
        Chain(strongLink!).then(Success()).finally { _ in }.run()
        strongLink = nil
        XCTAssertNil(weakLink)
    }

    func test_Chain_withFailingLink_diesOnceOperationsHaveFinished() {
        var strongLink: PassString? = PassString()
        weak var weakLink = strongLink
        Chain(strongLink!).then(Failure()).finally { _ in }.run()
        strongLink = nil
        XCTAssertNil(weakLink)
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

    class Async: PassiveLink<String> {

        override func run() {
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.01) * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue(), finish)
        }
    }

    class Success: Link<String, String> {
        override func run() {
            finish(result: "fin")
        }
    }

    class Failure: Link<String, String> {
        override func run() {
            finish(error: TestError.Some)
        }
    }
}
