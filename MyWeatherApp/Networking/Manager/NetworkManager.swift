//
//  NetworkManager.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 59//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}


struct NetworkManager {
    static let shared = NetworkManager()
    static let enviroment: NetworkEnvironment = .production
    static let WeatherAPIKey = "808a30a6bbd354bd8ae98dc386f1c004"
    let router = Router<WeatherApi>()
    
    func getWeather(coordinates: String, completion: @escaping (_ currentWeather: Weather?, _ error: String? )->()) {
        router.request(.locationFor(coordinates)) { (data, response, error) in
            if error != nil {
                completion(nil, "Check your connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let weather = try JSONDecoder().decode(Weather.self,
                                                                 from: responseData)
                        print(weather)
                        completion(weather, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
