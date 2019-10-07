//
//  HTTPTask.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 278//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String : String]

enum HTTPTask {
    case request
    
    case requestParameteres(bodyParameters: Parameters?, urlParameters: Parameters?)
    
}
