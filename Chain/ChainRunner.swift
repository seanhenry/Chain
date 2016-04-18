//
//  ChainRunner.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public class ChainRunner<T, U> {

    let chain: Chain<T, U>

    init(chain: Chain<T, U>) {
        self.chain = chain
    }

    public func run() {
        chain.findFirst().run()
    }
}
