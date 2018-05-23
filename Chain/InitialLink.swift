//
//  InitialLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

open class InitialLink<InitialType>: RunnableLink {

    open var initialValue: InitialType! {
        return initial.result
    }
    var initial: ChainResult<InitialType, Swift.Error> = .failure(ChainError.noInitialValue)
    var previous: RunnableLink?
    open func run() { }
    open func finish(error: Error) { }
}
