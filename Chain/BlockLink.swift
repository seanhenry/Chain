//
//  BlockLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

class BlockLink<PassedType>: PassiveLink<PassedType> {

    let block: (ChainResult<PassedType, ErrorProtocol> -> ())
    init(block: (ChainResult<PassedType, ErrorProtocol>) -> ()) {
        self.block = block
    }

    override func run() {
        block(initial)
    }

    override func finish(error error: ErrorProtocol) {
        block(.Failure(error))
    }
}
