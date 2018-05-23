//
//  MockLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class MockLink<InitialType, ResultType>: Link<InitialType, ResultType> {

    var didCallRun = false
    override func run() {
        didCallRun = true
    }

    var didCallFinishWithError = false
    override func finish(error: Error) {
        didCallFinishWithError = true
    }
}
