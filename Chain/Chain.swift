//
//  Chain.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public class Chain<InitialType, ResultType> {

    let last: Link<InitialType, ResultType>

    public init(_ link: Link<InitialType, ResultType>) {
        self.last = link
    }

    public func then<T>(link: Link<ResultType, T>) -> Chain<ResultType, T> {
        link.previous = last
        last.next = link
        return Chain<ResultType, T>(link)
    }

    public func finally(link: InitialLink<ResultType>) -> ChainRunner<InitialType, ResultType> {
        link.previous = last
        last.next = link
        return ChainRunner(chain: self)
    }

    public func finally(block: (ResultType) -> ()) -> ChainRunner<InitialType, ResultType> {
        let blockLink = BlockLink(block: block)
        last.next = blockLink
        return ChainRunner(chain: self)
    }

    func findFirst() -> Runnable {
        var previous: Runnable = last
        while let p = previous.previous {
            previous = p
        }
        return previous
    }
}
