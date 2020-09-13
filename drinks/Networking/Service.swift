//
//  Service.swift
//  coctails
//
//  Created by Macbook Air on 10.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

struct Service {
    
    private let base = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    
    private func buildDrinksURL(forCategory category: String) -> URL? {
        let stringUrl = base + "filter.php"
        guard var components = URLComponents(string: stringUrl) else { return nil }
        let queryParameter = URLQueryItem(name: "c", value: category)
        components.queryItems = [queryParameter]
        return components.url
    }
    
    private func buildCategoriesURL() -> URL? {
        let stringUrl = base + "list.php"
        guard var components = URLComponents(string: stringUrl) else { return nil }
        let queryParameter = URLQueryItem(name: "c", value: "list")
        components.queryItems = [queryParameter]
        return components.url
    }
    
    func fetchDrinks(forCategory category: String, completion: @escaping (Result<Drinks, ServiceError>) -> Void) {
        guard let url = buildDrinksURL(forCategory: category) else {
            DispatchQueue.main.async { completion(.failure(.creatingUrl)) }
            return
        }
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(.failure(.network)) }
                return
            }
                        
            do {
                let model = try JSONDecoder().decode(Drinks.self, from: data!)
                DispatchQueue.main.async { completion(.success(model)) }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(.failure(.decoding)) }
            }
        }.resume()
    }
    
    func fetchCategories(completion: @escaping (Result<[Category], ServiceError>) -> Void) {
        guard let url = buildCategoriesURL() else {
            DispatchQueue.main.async { completion(.failure(.creatingUrl)) }
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(.failure(.network)) }
                return
            }
                        
            do {
                let model = try JSONDecoder().decode(Catigories.self, from: data!)
                DispatchQueue.main.async { completion(.success(model.all)) }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(.failure(.decoding)) }
            }
        }.resume()
    }
}
