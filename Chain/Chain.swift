//
//  Chain.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

open class Chain<InitialType, ResultType>: Runnable {

    let last: Link<InitialType, ResultType>

    public init(_ link: Link<InitialType, ResultType>) {
        self.last = link
    }

    public init(initialValue: InitialType, _ link: Link<InitialType, ResultType>) {
        link.initial = .success(initialValue)
        self.last = link
    }

    open func then<T>(_ link: Link<ResultType, T>) -> Chain<ResultType, T> {
        link.previous = last
        last.next = link
        return Chain<ResultType, T>(link)
    }

    open func finally(_ block: @escaping (ChainResult<ResultType, Error>) -> ()) -> Runnable {
        let blockLink = BlockLink(block: block)
        last.next = blockLink
        return self
    }

    func findFirst() -> RunnableLink {
        var previous: RunnableLink = last
        while let p = previous.previous {
            previous = p
        }
        return previous
    }

    open func run() {
        findFirst().run()
    }
}
