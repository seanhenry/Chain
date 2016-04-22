//
//  PassiveLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public class PassiveLink<PassedType>: Link<PassedType, PassedType> {

    public override init() {}

    override public var initial: Result<PassedType, ErrorType> {
        didSet {
            result = initial
        }
    }

    public func finish() {
        next?.initial = result
        next?.run()
    }
}
