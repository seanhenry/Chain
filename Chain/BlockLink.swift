//
//  BlockLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

class BlockLink<InitialType>: Link<InitialType, ()> {

    let block: (Result<InitialType, ErrorType> -> ())
    init(block: (Result<InitialType, ErrorType>) -> ()) {
        self.block = block
    }

    override func run() {
        block(initial)
        finish()
    }
}
