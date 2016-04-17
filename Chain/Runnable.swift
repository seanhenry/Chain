//
//  Runnable.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

protocol Runnable: class {
    var previous: Runnable? { get }
    func main(done: () -> ())
    func finish()
    func run()
}
