//
//  PassiveLinkTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class PassiveLinkTests: XCTestCase {
    
    var link: PassiveLink<String>!
    
    override func setUp() {
        super.setUp()
        link = PassiveLink()
    }
    
    // MARK: - initial
    
    func test_initial_shouldSetResult() {
        link.initial = .Success("some")
        XCTAssertTrue(link.result.isSuccessWithResult(link.initial.result))
    }
}
