//
//  Link.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Foundation

public class Link<InitialType, ResultType>: InitialLink<InitialType> {

    var result: ChainResult<ResultType, ErrorProtocol> = .Failure(Error.NoResultValue)
    var next: InitialLink<ResultType>?

    public override init() {}

    public func finish(result: ResultType) {
        previous = nil
        next?.initial = .Success(result)
        next?.run()
    }

    public override func finish(error: ErrorProtocol) {
        previous = nil
        next?.initial = .Failure(error)
        next?.finish(error: error)
    }
}
