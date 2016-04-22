//
//  BlockLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

class BlockLink<InitialType>: Link<InitialType, ()> {

    let block: (InitialType -> ())
    init(block: (InitialType) -> ()) {
        self.block = block
    }

    override func run(done: () -> ()) {
        block(initial)
        done()
    }
}
