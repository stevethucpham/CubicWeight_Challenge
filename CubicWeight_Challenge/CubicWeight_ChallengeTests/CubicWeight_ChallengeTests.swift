//
//  CubicWeight_ChallengeTests.swift
//  CubicWeight_ChallengeTests
//
//  Created by iOS Developer on 1/11/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import XCTest
@testable import CubicWeight_Challenge

class CubicWeight_ChallengeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCalculateCubicWeight() {
        let size = Size(width: 40, length: 20, height: 30)
        XCTAssertEqual(AirConditionCubicCalculation.calculateCubic(size: size), 0.024)
        XCTAssertEqual(AirConditionCubicCalculation.getCubicWeight(size: size), 6)
    }
    
    func testCalculateCubicWeighWithoutSize() {
        let size = Size(width: nil, length: nil, height: nil)
        XCTAssertEqual(AirConditionCubicCalculation.calculateCubic(size: size), 0.0)
        XCTAssertEqual(AirConditionCubicCalculation.getCubicWeight(size: size), 0.0)
    }

}
