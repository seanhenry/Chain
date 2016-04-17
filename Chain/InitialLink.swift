//
//  InitialLink.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Swift

public class InitialLink<InitialType>: Runnable {

    public var initial: InitialType!
    var previous: Runnable?

    public func main(done: () -> ()) { }

    func run() {
        main { [unowned self] in
            self.finish()
        }
    }

    func finish() { }
}
