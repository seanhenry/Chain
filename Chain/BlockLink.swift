//
//  BlockLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

class BlockLink<PassedType>: PassiveLink<PassedType> {

    let block: ((ChainResult<PassedType, Error>) -> ())
    init(block: @escaping (ChainResult<PassedType, Error>) -> ()) {
        self.block = block
    }

    override func run() {
        block(initial)
    }

    override func finish(error: Swift.Error) {
        block(.failure(error))
    }
}
