//
//  WeatherEndPoint.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 298//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case staging
    case production
}

enum WeatherApi {
    case locationFor(_ coordinates: String)
}

extension  WeatherApi: EndPointType {
    
    var environmentBaseURL: String {
        return "https://api.darksky.net/forecast/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .locationFor(let coordinates):
            return coordinates
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .locationFor:
            return .requestParameteres(bodyParameters: nil,
                                       urlParameters: ["exclude" : "hourly,alerts,flags",
                                                       "units" : "si"])
        }
    }
}
