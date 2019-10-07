//
//  EndPointType.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 278//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
//    var headers: HTTPHeader? { get }
}
