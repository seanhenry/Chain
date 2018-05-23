//
//  Result.swift
//
//  Copyright © 2016 Sean Henry. All rights reserved.
//

import Foundation

public enum ChainResult<ResultType, ErrorType> {
    case success(ResultType)
    case failure(ErrorType)
}

extension ChainResult {

    public var result: ResultType? {
        guard case .success(let result) = self else {
            return nil
        }
        return result
    }

    public var error: ErrorType? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }
}

extension ChainResult where ResultType: Equatable {

    public func isSuccessWithResult(_ result: ResultType?) -> Bool {
        guard case .success(let r) = self else {
            return false
        }
        return r == result
    }
}

extension ChainResult where ErrorType: Equatable {

    public func isFailureWithError(_ error: ErrorType?) -> Bool {
        guard case .failure(let e) = self else {
            return false
        }
        return e == error
    }
}
