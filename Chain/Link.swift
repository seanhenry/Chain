//
//  Link.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Foundation

public class Link<InitialType, ResultType>: InitialLink<InitialType> {

    var result: Result<ResultType, ErrorType> = .Failure(Error.NoResultValue)
    var next: InitialLink<ResultType>?

    public override init() {}

    public func finish(result result: ResultType) {
        next?.initial = .Success(result)
        next?.run()
    }

    public override func finish(error error: ErrorType) {
        next?.initial = .Failure(error)
        next?.finish(error: error)
    }
}
