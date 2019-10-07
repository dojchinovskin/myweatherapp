//
//  Router.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 298//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameteres(bodyParameters: let bodyParameters, urlParameters: let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                         urlParameters: urlParameters,
                                         request: &request)
                
            }
        }
        request.url?.appendPathComponent(NetworkManager.WeatherAPIKey)
        request.url?.appendPathComponent(route.path)
        
        return request
        
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoding.encode(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoding.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
        
    }
    
}
