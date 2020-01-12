//
//  TestViewModel.swift
//  CubicWeight_ChallengeTests
//
//  Created by iOS Developer on 1/12/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import XCTest
@testable import CubicWeight_Challenge

class TestViewModel: XCTestCase {
    var viewModel: ProductViewModelType!
    
    override func setUp() {
        let mockTramSession = MockSuccessSession()
        let productService = ProductService(session: mockTramSession)
        viewModel = ProductViewModel(service: productService)
        viewModel.reloadTable =  { [weak self] in
           
        }
        
        viewModel.showAlertClosure = { [weak self] error in
            
        }
        viewModel.loadNextPage()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfProducts() {
        
        XCTAssertEqual(viewModel.getProductCount(), 5)
    }
    
    func testAverageAirConditionCubicWeight() {
        
        let size1 = Size(width: 26, length: 26, height: 5)
        let size2 = Size(width: 49.6, length: 38.7, height: 89)
        
        let manualAverage = (AirConditionCubicCalculation.getCubicWeight(size: size1) +  AirConditionCubicCalculation.getCubicWeight(size: size2))/2
        
        let average = viewModel.calculateACAverageCubicWeight()
        XCTAssertEqual(manualAverage, average)
    }
    
    func testGetTitle() {
        let title = viewModel.getTitle(at: 0)
        XCTAssertEqual(title, "10 Pack Family Car Sticker Decals")
    }
    
    func testGetCategory() {
        let category = viewModel.getCategory(at: 0)
        XCTAssertEqual(category, "Gadgets")
    }

}
