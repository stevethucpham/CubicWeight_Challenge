//
//  ProductService.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/11/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import Foundation

// MARK: Service Type
protocol ProductServiceType {
    
    /// URL Request Session
    var session: URLSession { get }

    
    /// This API request the API and decode the JSON Response
    /// - Parameters:
    ///   - url: API URL
    ///   - completionHandler: the completion handler which returns a decodable type if success, otherwise returns error.
    func request<T: Decodable> (from url: URL, completionHandler: @escaping (ServiceResult<T>) -> Void)
    
    func getProducts(pagination: String, completion: @escaping (ServiceResult<ResponseObject>) -> Void)
}

// MARK: Extension Service Type
extension ProductServiceType {
    /// This function requests the API and deserialize the JSON into the model
    /// - Parameters:
    ///   - url: API URL
    ///   - completionHandler: the completion handler which returns a decodable type if success, otherwise returns error.
    func request<T: Decodable> (from url: URL, completionHandler: @escaping (ServiceResult<T>) -> Void) {
        let task = session.dataTask(with: url) { data, response , error in
            
            guard let dataObject = data else { completionHandler(.failure(error)); return  }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(ApiError.serverError))
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: dataObject)
                debugPrint(jsonResponse)
                completionHandler(.success(jsonResponse))
            } catch {
                completionHandler(.failure(ApiError.serialization))
            }
            
        }
        task.resume()
    }
}

class ProductService: ProductServiceType {
    
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getProducts(pagination: String, completion: @escaping (ServiceResult<ResponseObject>) -> Void) {
        let url = URL(string: "\(Constants.Service.baseURL)\(pagination)")!
        request(from: url) { (result: ServiceResult<ResponseObject>) in
            switch result {
            case .success(let response):
                completion(ServiceResult.success(response))
                break
            case .failure(let error):
                completion(ServiceResult.failure(error))
                break
            }
        }
    }
}
