//
//  Chain.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public class Chain<InitialType, ResultType>: Runnable {

    let last: Link<InitialType, ResultType>

    public init(_ link: Link<InitialType, ResultType>) {
        self.last = link
    }

    public func then<T>(link: Link<ResultType, T>) -> Chain<ResultType, T> {
        link.previous = last
        last.next = link
        return Chain<ResultType, T>(link)
    }

    public func finally(block: (Result<ResultType, ErrorType>) -> ()) -> Runnable {
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

    public func run() {
        findFirst().run()
    }
}
