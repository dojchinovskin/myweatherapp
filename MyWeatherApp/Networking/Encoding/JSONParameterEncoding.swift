//
//  JSONParameterEncoding.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 298//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

struct JSONParameterEncoding: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters,
                                                        options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
