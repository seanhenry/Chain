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
        result = .failure("")
        XCTAssertNil(result.result)
    }

    func test_result_shouldBeCorrectValue_whenUnderlyingTypeIsSuccess() {
        result = .success("hello")
        XCTAssertEqual(result.result, "hello")
    }

    // MARK: - error

    func test_error_shouldBeNil_whenUnderlyingTypeIsSuccess() {
        result = .success("")
        XCTAssertNil(result.error)
    }

    func test_error_shouldBeCorrectValue_whenUnderlyingTypeIsFailure() {
        result = .failure("hello")
        XCTAssertEqual(result.error, "hello")
    }

    // MARK: - isSuccessWithResult

    func test_isSuccessWithResult_shouldBeFalse_whenResultIsNil() {
        result = .failure("")
        XCTAssertFalse(result.isSuccessWithResult(nil))
    }

    func test_isSuccessWithResult_shouldBeFalse_whenNotSuccess() {
        result = .failure("")
        XCTAssertFalse(result.isSuccessWithResult(""))
    }

    func test_isSuccessWithResult_shouldBeFalse_whenSuccessIsNotEqual() {
        result = .success("123")
        XCTAssertFalse(result.isSuccessWithResult("456"))
    }

    func test_isSuccessWithResult_shouldBeTrue_whenSuccessIsEqual() {
        result = .success("123")
        XCTAssertTrue(result.isSuccessWithResult("123"))
    }

    // MARK: - isFailureWithError

    func test_isFailureWithError_shouldBeFalse_whenErrorIsNil() {
        result = .failure("")
        XCTAssertFalse(result.isFailureWithError(nil))
    }

    func test_isFailureWithError_shouldBeFalse_whenNotFailure() {
        result = .success("")
        XCTAssertFalse(result.isFailureWithError(""))
    }

    func test_isFailureWithError_shouldBeFalse_whenFailureIsNotEqual() {
        result = .failure("123")
        XCTAssertFalse(result.isFailureWithError("456"))
    }

    func test_isFailureWithError_shouldBeTrue_whenFailureIsEqual() {
        result = .failure("123")
        XCTAssertTrue(result.isFailureWithError("123"))
    }
}
