//
//  NetworkRouter.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 298//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
