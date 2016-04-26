//
//  Result.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Foundation

public enum ChainResult<ResultType, ErrorType> {
    case Success(ResultType)
    case Failure(ErrorType)
}

extension ChainResult {

    public var result: ResultType? {
        guard case .Success(let result) = self else {
            return nil
        }
        return result
    }

    public var error: ErrorType? {
        guard case .Failure(let error) = self else {
            return nil
        }
        return error
    }
}

extension ChainResult where ResultType: Equatable {

    public func isSuccessWithResult(result: ResultType?) -> Bool {
        guard case .Success(let r) = self else {
            return false
        }
        return r == result
    }
}

extension ChainResult where ErrorType: Equatable {

    public func isFailureWithError(error: ErrorType?) -> Bool {
        guard case .Failure(let e) = self else {
            return false
        }
        return e == error
    }
}
