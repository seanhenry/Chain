//
//  Runnable.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public protocol Runnable: class {
    func run()
}

protocol RunnableLink: class {
    var previous: RunnableLink? { get }
    func run()
    func finish()
}
