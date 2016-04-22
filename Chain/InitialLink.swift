//
//  InitialLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public class InitialLink<InitialType>: RunnableLink {

    public var initial: Result<InitialType, ErrorType> = .Failure(Error.NoInitialValue)
    var previous: RunnableLink?
    public func run() { }
    public func finish(error error: ErrorType) { }
}
