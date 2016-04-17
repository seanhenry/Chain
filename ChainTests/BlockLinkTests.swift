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
    var block: ((String) -> ())!
    var link: BlockLink<String>!

    override func setUp() {
        super.setUp()
        didCallBlock = false
        didCallDone = false
        block = { string in
            self.didCallBlock = true
        }
        link = BlockLink<String>(block: block)
        link.initial = "howdy"
    }
    
    // MARK: - main
    
    func test_main_shouldCallBlock() {
        main()
        XCTAssertTrue(didCallBlock)
    }

    func test_main_shouldCallDone() {
        main()
        XCTAssertTrue(didCallDone)
    }

    // MARK: - Helpers

    func main() {
        link.main {
            self.didCallDone = true
        }
    }
}
