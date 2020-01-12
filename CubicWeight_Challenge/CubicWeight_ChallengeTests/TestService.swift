//
//  TestService.swift
//  CubicWeight_ChallengeTests
//
//  Created by iOS Developer on 1/12/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import XCTest
@testable import CubicWeight_Challenge

class TestService: XCTestCase {
    
    var productService: ProductServiceType!

    override func setUp() {
        let mockSession = MockSuccessSession()
        productService = ProductService(session: mockSession)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetProducts() {
        productService.getProducts(pagination: "/api/products/1") { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.products?.count, 5)
                XCTAssertEqual(response.products![0].title, "10 Pack Family Car Sticker Decals")
                XCTAssertEqual(response.products![0].category, "Gadgets")
                XCTAssertEqual(response.products![0].size?.height, 1.0)
                XCTAssertEqual(response.products![0].size?.width, 15.0)
                XCTAssertEqual(response.products![0].size?.length, 13.0)
                break
            case .failure(_):
                XCTFail()
                break
            }
        }
    }
    
    func testGetProductFailure() {
        let mockFailSession = MockFailSession()
        let productService = ProductService(session: mockFailSession)
        
        productService.getProducts(pagination: "/api/products/1") { (result) in
            switch result {
            case .success(_):
                XCTFail()
                break
            case .failure(let error):
                let isError = error?.localizedDescription.hasPrefix("Something went wrong")
                XCTAssertTrue(isError ?? false)
                break
            }
        }
    }
    
}
