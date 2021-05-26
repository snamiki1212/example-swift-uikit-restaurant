//
//  MenuController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import Foundation

class MenuController {
    static let shared = MenuController()
    let baseURL = URL(string: "http://localhost:8080/")!
    
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        //
        let categoriesURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoriesURL) { data, response, error in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let categoreisResponse = try jsonDecoder.decode(CategoriesResponse.self, from: data)
                    completion(.success(categoreisResponse.categories))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        //
        let baseMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: baseMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { data, response, error in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let menuResponse = try
                       jsonDecoder.decode(MenuResponse.self, from: data)
                    completion(.success(menuResponse.items))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    typealias MinusToPrepare = Int
    func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Result<MinusToPrepare, Error>) -> Void) {
        //
        let orderURL = baseURL.appendingPathComponent("order")

        let data = ["menuIDs": menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)

        var request = URLRequest(url: orderURL)
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let orderResponse = try
                       jsonDecoder.decode(OrderResponse.self, from: data)
                    completion(.success(orderResponse.prepTime))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
