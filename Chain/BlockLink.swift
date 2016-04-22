//
//  BlockLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

class BlockLink<PassedType>: PassiveLink<PassedType> {

    let block: (Result<PassedType, ErrorType> -> ())
    init(block: (Result<PassedType, ErrorType>) -> ()) {
        self.block = block
    }

    override func run() {
        block(initial)
    }

    override func finish(error error: ErrorType) {
        block(.Failure(error))
    }
}
