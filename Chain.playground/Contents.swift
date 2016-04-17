//: # Build the Chain framework first

import Foundation
import UIKit
import Chain

class IntGenerator: Link<(), Int> {

    override func main(done: () -> ()) {
        result = 42
        done()
    }
}

class IntToString: Link<Int, String> {

    override func main(done: () -> ()) {
        result = String(initial)
        done()
    }
}

class Print: Link<String, ()> {

    override func main(done: () -> ()) {
        print(initial ?? "nil")
        done()
    }
}

class Add: Link<Int, Int> {

    let value: Int
    init(_ value: Int) {
        self.value = value
    }

    override func main(done: () -> ()) {
        result = (initial ?? -10000) + value
        done()
    }
}

class Delay<PassedType>: PassiveLink<PassedType> {

    override func main(done: () -> ()) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5) * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue(), {
            done()
        })
    }
}

class JustPrint<PassedType>: PassiveLink<PassedType> {

    override func main(done: () -> ()) {
        print("Just printing")
        done()
    }
}

Chain(IntGenerator()).then(IntToString()).finally { result in
    print("block " + result)
}.run()
Chain(IntGenerator()).then(IntToString()).finally(Print()).run()
Chain(IntGenerator()).then(JustPrint()).then(IntToString()).finally(Print()).run()
Chain(IntGenerator()).then(Add(50)).then(IntToString()).then(JustPrint()).then(Delay()).finally(Print()).run()

NSRunLoop.mainRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 1))
