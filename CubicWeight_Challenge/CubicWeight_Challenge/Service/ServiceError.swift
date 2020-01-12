//
//  RequestError.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/11/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import Foundation

/// API Error Exception
enum ApiError: Error {
    case serverError
    case serialization
    case noToken
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError:
            return NSLocalizedString("Something went wrong when requesting data", comment: "")
        case .serialization:
            return NSLocalizedString("Serialization error", comment: "")
        case .noToken:
            return NSLocalizedString("Cannot get token", comment: "")
        }
        
    }
}
