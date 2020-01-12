//
//  ProductViewModel.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/11/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import Foundation

protocol ProductViewModelType {
    /// The callback to show alert when with error message
    var showAlertClosure: ((String)->())? { get set }

    /// Callback to reload table when data is loaded
    var reloadTable: (()->())? { get set }
    
    var isDisableNextButton: (()->())? { get set }
    
    /// Get total number of products
    func getProductCount() -> Int
    
    /// Get title of the product
    /// - Parameter index: index of cell
    func getTitle(at index: Int) -> String?
    
    /// Get category of the product
    /// - Parameter index: index of cell
    func getCategory(at index: Int) -> String?
    
    /// Calculate average cubic weight of the product with category = "Air conditioners"
    func calculateACAverageCubicWeight() -> Float
    
    /// Load next page
    func loadNextPage()
}

class ProductViewModel: ProductViewModelType {
    
    private(set) var service: ProductServiceType
    
    private var nextPage: String? = "/api/products/1"
    private var products: [Product]?
    
    // MARK: Output
    var showAlertClosure: ((String) -> ())?
    var reloadTable: (()->())?
    var isDisableNextButton: (()->())?
    
    func getProductCount() -> Int {
        if let products = products {
            return products.count
        }
        return 0
    }
    
    func getTitle(at index: Int) -> String? {
        if let products = products {
            return products[index].title
        }
        return nil
    }
       
    func getCategory(at index: Int) -> String? {
        if let products = products {
            return products[index].category
        }
        return nil
    }
    
    init(service: ProductServiceType = ProductService()) {
        self.service = service

    }
    
    func loadNextPage() {
        if let nextPage = self.nextPage {
            loadProduct(pagination: nextPage)
        } else {
            debugPrint("End loading page")
            guard let disable = isDisableNextButton else { return }
            disable()
        }
    }
    
    func loadProduct(pagination: String) {
        guard let reloadTable = reloadTable, let showAlertClosure = showAlertClosure else {
            return
        }
        service.getProducts(pagination: pagination) { [weak self] (result) in
            switch result {
            case .success(let response):
                debugPrint(response.products?.count ?? 0)
                if var products = self?.products, let responseProducts = response.products {
                    products += responseProducts
                    self?.products = products
                } else {
                    self?.products = response.products
                }
                self?.nextPage = response.next
//                self?.loadNextPage()
                break
            case .failure(let error):
                showAlertClosure(error?.localizedDescription ?? "Something went wrong")
                break
            }
            reloadTable()
        }
    }
    
    func calculateACAverageCubicWeight() -> Float {
        if let products = self.products {
            let filterProducts = products.filter { $0.category! == "Air Conditioners" }.map { return AirConditionCubicCalculation.getCubicWeight(size: $0.size!) }
            let average = filterProducts.reduce (Float(0.0)) { (value1, value2) in
                return value1 + value2/Float(filterProducts.count)
            }
            return average.roundToDecimal(3)
        }
        return 0.0
    }
    
}
