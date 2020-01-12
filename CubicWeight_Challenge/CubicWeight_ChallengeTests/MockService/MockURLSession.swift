//
//  MockURLSession.swift
//  CubicWeight_ChallengeTests
//
//  Created by iOS Developer on 1/12/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import Foundation
@testable import CubicWeight_Challenge

class MockURLSessionDataTask: URLSessionDataTask {
  override func resume() {
    print("mock resume")
  }
}

// MARK: Mock Tram Service Session
class MockSuccessSession: URLSession {
  override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

    let jsonString =  """
{
    "objects": [
        {
            "category": "Gadgets",
            "title": "10 Pack Family Car Sticker Decals",
            "weight": 120.0,
            "size": {
                "width": 15.0,
                "length": 13.0,
                "height": 1.0
            }
        },
        {
            "category": "Air Conditioners",
            "title": "Window Seal for Portable Air Conditioner Outlets",
            "weight": 235.0,
            "size": {
                "width": 26.0,
                "length": 26.0,
                "height": 5.0
            }
        },
        {
            "category": "Batteries",
            "title": "10 Pack Kogan CR2032 3V Button Cell Battery",
            "weight": 60.0,
            "size": {
                "width": 5.8,
                "length": 19.0,
                "height": 0.3
            }
        },
        {
            "category": "Cables & Adapters",
            "title": "3 Pack Apple MFI Certified Lightning to USB Cable (3m)",
            "weight": 90.0,
            "size": {
                "width": 10.0,
                "length": 20.0,
                "height": 3.0
            }
        },
        {
            "category": "Air Conditioners",
            "title": "Kogan 10,000 BTU Portable Air Conditioner (2.9KW)",
            "weight": 26200.0,
            "size": {
                "width": 49.6,
                "length": 38.7,
                "height": 89.0
            }
        }
    ],
    "next": "/api/products/2"
}
"""
    let data = jsonString.data(using: .utf8)!
    let response = HTTPURLResponse(url: URL(string: Constants.Service.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
    completionHandler(data, response, nil)

    return MockURLSessionDataTask()
  }
}

// MARK: Mock Fail Session
class MockFailSession: URLSession {
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let jsonString =  """
{
  
}
"""
        let data = jsonString.data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: Constants.Service.baseURL)!, statusCode: 500, httpVersion: nil, headerFields: nil)
        completionHandler(data, response, nil)
        
        return MockURLSessionDataTask()
    }
}
