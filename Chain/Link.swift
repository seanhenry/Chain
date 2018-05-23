//
//  Link.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Foundation

open class Link<InitialType, ResultType>: InitialLink<InitialType> {

    var result: ChainResult<ResultType, Swift.Error> = .failure(ChainError.noResultValue)
    var next: InitialLink<ResultType>?

    public override init() {}

    open func finish(result: ResultType) {
        previous = nil
        next?.initial = .success(result)
        next?.run()
    }

    open override func finish(error: Error) {
        previous = nil
        next?.initial = .failure(error)
        next?.finish(error: error)
    }
}
