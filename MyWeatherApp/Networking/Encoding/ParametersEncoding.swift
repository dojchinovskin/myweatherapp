//
//  ParametersEncoding.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 278//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

typealias Parameters  = [String : Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum NetworkError: String, Error{
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Paramteres encoding failed."
    case missingURL = "URL is nil."
}
