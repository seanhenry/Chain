import Foundation
import Chain
/*: 
 # Chain
 A Swift library for linking tasks together and passing data between those tasks.

 ## Simple Example
 Suppose you have asked the user for an integer value and want to perform some multiplication on that number.
*/
class MultiplyBy: Link<Int, Int> {

    let factor: Int
    init(_ factor: Int) {
        self.factor = factor
    }

    override func run() {
        let result = initialValue * factor
        finish(result: result)
    }
}

Chain(initialValue: 15, MultiplyBy(10)).finally { result in
    print(result) // => 150
}.run()
/*:
 Now suppose you want to convert that number to words. You can easily link two tasks together providing the output type of the previous link matches the input type of the next link.
 */
class IntToWords: Link<Int, String> {

    override func run() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        let result = formatter.string(from: initialValue as NSNumber!)!
        finish(result: result)
    }
}

Chain(initialValue: 15, MultiplyBy(10))
    .then(IntToWords())
    .finally { result in
    print(result) // => "one hundred fifty"
}.run()
/*:
 Sometimes tasks are not interested in the input or output. Here we can create a passive link which will simply pass on the value from one link to the next.
 */
class Boast<IgnoredType>: PassiveLink<IgnoredType> {

    override func run() {
        print("I will now convert your number into text.")
        finish()
    }
}

Chain(initialValue: 15, MultiplyBy(10))
    .then(Boast()) // => "I will now convert your number into text."
    .then(IntToWords())
    .finally { result in
    print(result) // => "one hundred fifty"
}.run()
/*:
 Tasks can be asynchronous, like network requests or animations.
 */
class PauseForEffect<IgnoredType>: PassiveLink<IgnoredType> {

    override func run() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: finish)
    }
}

Chain(initialValue: 15, MultiplyBy(10))
    .then(Boast())
    .then(PauseForEffect()) // IntToWords is not called until the pause is finished.
    .then(IntToWords())
    .finally { result in
    print(result)
}.run()
/*:
 Tasks can fail. And when they do the error is passed to the end of the Chain and the next links are ignored.
 */
enum MyError: Error {
    case NumberTooHigh
}

class ICanOnlyCountTo: Link<Int, Int> {

    let max: Int
    init(_ max: Int) {
        self.max = max
    }

    override func run() {
        if initialValue < max {
            finish(result: initialValue)
        } else {
            finish(error: MyError.NumberTooHigh)
        }
    }
}

Chain(initialValue: 15, MultiplyBy(10))
    .then(Boast())
    .then(PauseForEffect())
    .then(ICanOnlyCountTo(100))
    .then(IntToWords())
    .finally { result in
    print(result) // => MyError.NumberTooHigh
}.run()

RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
