//
//  InitialLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public class InitialLink<InitialType>: RunnableLink {

    public var initial: InitialType!
    var previous: RunnableLink?

    public func run(done: () -> ()) { }

    func run() {
        run { [unowned self] in
            self.finish()
        }
    }

public class InitialLink<InitialType>: RunnableLink {

    public var initial: Result<InitialType, ErrorType> = .Failure(ChainError.NoInitialValue)
    var previous: RunnableLink?
    public func run() { }
}
