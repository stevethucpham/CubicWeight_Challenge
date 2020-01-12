//
//  Product.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/11/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import Foundation

struct ResponseObject: Decodable {
    var products: [Product]?
    var next: String?
    
    enum CodingKeys: String, CodingKey {
        case products = "objects"
        case next = "next"
    }
}

struct Product: Decodable {
    var category: String?
    var title: String?
    var weight: Float?
    var size: Size?
}

struct Size: Decodable {
    var width: Float?
    var length: Float?
    var height: Float?
}


