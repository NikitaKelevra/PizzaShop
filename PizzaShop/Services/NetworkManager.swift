//
//  NetworkManager.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 26.04.2022.
//

import Foundation

// MARK: Менеджер сетевых запросов
final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Через замыкание захватывает список продуктов, полученных в ответ на HTTP запрос
    func fetchProducts(completion: @escaping (_ products: [Product]) -> Void) {
        
        let urlAdress = "https://burgers1.p.rapidapi.com/burgers"
        guard let url = URL(string: urlAdress) else { return }
        
        let headers = [
            "X-RapidAPI-Host": "burgers1.p.rapidapi.com",
            "X-RapidAPI-Key": "513499b3cfmshc7aca0fd4e9db26p14feffjsn3073bc7d5e05"
        ]
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 25.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, responce, error in
            if let responce = responce {
                print(responce)
            }
            
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode([Product].self, from: data)
                
                DispatchQueue.main.async {
                    completion(data)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
