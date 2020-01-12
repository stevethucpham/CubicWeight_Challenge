//
//  ServiceResult.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/11/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import Foundation

// MARK: Network Result
enum ServiceResult<T> {
    case success(T)
    case failure(Error?)
}
