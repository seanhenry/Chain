//
//  ChainResultTests.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import XCTest
@testable import Chain

class ChainResultTests: XCTestCase {

    var result: ChainResult<String, String>!

    // MARK: - result

    func test_result_shouldBeNil_whenUnderlyingTypeIsFailure() {
        result = .Failure("")
        XCTAssertNil(result.result)
    }

    func test_result_shouldBeCorrectValue_whenUnderlyingTypeIsSuccess() {
        result = .Success("hello")
        XCTAssertEqual(result.result, "hello")
    }

    // MARK: - error

    func test_error_shouldBeNil_whenUnderlyingTypeIsSuccess() {
        result = .Success("")
        XCTAssertNil(result.error)
    }

    func test_error_shouldBeCorrectValue_whenUnderlyingTypeIsFailure() {
        result = .Failure("hello")
        XCTAssertEqual(result.error, "hello")
    }

    // MARK: - isSuccessWithResult

    func test_isSuccessWithResult_shouldBeFalse_whenResultIsNil() {
        result = .Failure("")
        XCTAssertFalse(result.isSuccess(with: nil))
    }

    func test_isSuccessWithResult_shouldBeFalse_whenNotSuccess() {
        result = .Failure("")
        XCTAssertFalse(result.isSuccess(with: ""))
    }

    func test_isSuccessWithResult_shouldBeFalse_whenSuccessIsNotEqual() {
        result = .Success("123")
        XCTAssertFalse(result.isSuccess(with: "456"))
    }

    func test_isSuccessWithResult_shouldBeTrue_whenSuccessIsEqual() {
        result = .Success("123")
        XCTAssertTrue(result.isSuccess(with: "123"))
    }

    // MARK: - isFailureWithError

    func test_isFailureWithError_shouldBeFalse_whenErrorIsNil() {
        result = .Failure("")
        XCTAssertFalse(result.isFailure(with: nil))
    }

    func test_isFailureWithError_shouldBeFalse_whenNotFailure() {
        result = .Success("")
        XCTAssertFalse(result.isFailure(with: ""))
    }

    func test_isFailureWithError_shouldBeFalse_whenFailureIsNotEqual() {
        result = .Failure("123")
        XCTAssertFalse(result.isFailure(with: "456"))
    }

    func test_isFailureWithError_shouldBeTrue_whenFailureIsEqual() {
        result = .Failure("123")
        XCTAssertTrue(result.isFailure(with: "123"))
    }
}
