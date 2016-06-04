//
//  Result.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Foundation

public enum ChainResult<ResultType, ErrorProtocol> {
    case Success(ResultType)
    case Failure(ErrorProtocol)
}

extension ChainResult {

    public var result: ResultType? {
        guard case .Success(let result) = self else {
            return nil
        }
        return result
    }

    public var error: ErrorProtocol? {
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

extension ChainResult where ErrorProtocol: Equatable {

    public func isFailureWithError(error: ErrorProtocol?) -> Bool {
        guard case .Failure(let e) = self else {
            return false
        }
        return e == error
    }
}
