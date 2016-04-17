//
//  ChainRunnerTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class ChainRunnerTests: XCTestCase {
    
    var runner: ChainRunner<String, String>!
    var mockedChain: MockChain!
    var mockedRunnable: MockRunnable!
    
    override func setUp() {
        super.setUp()
        mockedRunnable = MockRunnable()
        mockedChain = MockChain()
        mockedChain.stubRunnable = mockedRunnable
        runner = ChainRunner(chain: mockedChain)
    }
    
    // MARK: - run
    
    func test_run_shouldFindFirst() {
        callRun()
        XCTAssertTrue(mockedChain.didCallFindFirst)
    }

    func test_run_shouldCallRunOnFirst() {
        callRun()
        XCTAssertTrue(mockedRunnable.didCallRun)
    }

    // MARK: - Helpers

    func callRun() {
        runner.run()
    }

    class MockChain: Chain<String, String> {
        init() {
            super.init(Link())
        }

        var didCallFindFirst = false
        var stubRunnable: Runnable!
        override func findFirst() -> Runnable {
            didCallFindFirst = true
            return stubRunnable
        }
    }

    class MockRunnable: Runnable {
        var previous: Runnable?
        func main(done: () -> ()) {}
        func finish() {}

        var didCallRun = false
        func run() {
            didCallRun = true
        }
    }
}

