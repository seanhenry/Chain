//
//  Link.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Foundation

public class Link<InitialType, ResultType>: InitialLink<InitialType> {

    public var result: Result<ResultType, ErrorType> = .Failure(ChainError.NoResultValue)
    var next: InitialLink<ResultType>?

    public override init() {}

    override func finish() {
        next?.initial = result
        next?.run()
    }
}
