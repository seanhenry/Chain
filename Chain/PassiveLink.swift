//
//  PassiveLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public class PassiveLink<PassedType>: Link<PassedType, PassedType> {

    public override init() {}

    override public var initial: ChainResult<PassedType, ErrorProtocol> {
        didSet {
            result = initial
        }
    }

    public func finish() {
        previous = nil
        next?.initial = result
        next?.run()
    }
}
