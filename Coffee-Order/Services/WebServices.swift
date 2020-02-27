//
//  WebServices.swift
//  Coffee-Order
//
//  Created by Ashutosh Purushottam on 24/02/20.
//  Copyright © 2020 Ashutosh Purushottam. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET = "get"
    case POST = "post"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HTTPMethod = .GET
    var body: Data? = nil
    
    init(url: URL) {
        self.url = url 
    }
}

enum NetworkError: Error {
    case domainError
    case decodingError
    case urlError
}

class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()

    }
}
