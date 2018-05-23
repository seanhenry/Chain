//
//  PassiveLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

open class PassiveLink<PassedType>: Link<PassedType, PassedType> {

    public override init() {}

    override open var initial: ChainResult<PassedType, Swift.Error> {
        didSet {
            result = initial
        }
    }

    open func finish() {
        previous = nil
        next?.initial = result
        next?.run()
    }
}
