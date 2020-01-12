//
//  CubicCalculation.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/12/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import Foundation


class AirConditionCubicCalculation {
   
    static func calculateCubic(size: Size) -> Float {
        guard let width = size.width, let height = size.height, let length = size.length else {
            return 0.0
        }
        return (width/100 * height/100 * length/100).roundToDecimal(3)
    }
    
    static func getCubicWeight(size: Size) -> Float {
        return calculateCubic(size: size) * 250
    }
    
}
