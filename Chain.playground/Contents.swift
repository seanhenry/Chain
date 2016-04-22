//: # Build the Chain framework first

import UIKit
import Chain

class IntGenerator<Ignored>: Link<Ignored, Int> {

    override func run() {
        finish(result: 42)
    }
}

class IntToString: Link<Int, String> {

    override func run() {
        finish(result: String(initialValue))
    }
}

class Add: PassiveLink<Int> {

    let value: Int
    init(_ value: Int) {
        self.value = value
    }

    override func run() {
        finish(result: initialValue + value)
    }
}

class Delay<PassedType>: PassiveLink<PassedType> {

    override func run() {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5) * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue(), finish)
    }
}

class JustPrint<PassedType>: PassiveLink<PassedType> {

    override func run() {
        print("Just printing")
        finish()
    }
}

Chain(IntGenerator<Void>()).then(IntToString()).finally { result in
    print("IntToString: \(result)")
}.run()
Chain(IntGenerator<Void>()).then(Add(50)).then(IntToString()).finally { result in
    print("Passive Link: \(result)")
}.run()
Chain(IntGenerator<Void>()).then(IntToString()).then(Delay()).finally { result in
    print("Asynchronous: \(result)")
}.run()

enum Error: ErrorType {
    case Error1
}

class FailLink<Ignored>: Link<Ignored, String> {

    override func run() {
        finish(error: Error.Error1)
    }
}

class SuccessLink<Ignored>: Link<Ignored, String> {

    override func run() {
        finish(result: "yay!")
    }
}

Chain(FailLink<Void>()).then(SuccessLink()).finally { result in
    print("Failure: \(result)")
}.run()

Chain(SuccessLink<()>()).then(SuccessLink()).finally { result in
    print("Success: \(result)")
}.run()

NSRunLoop.mainRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 1))
