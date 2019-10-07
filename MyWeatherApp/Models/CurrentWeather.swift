//
//  CurrentWeather.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 310//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let apparentTemp: Double
    let temperature: Double
    let uvIndex: Int
}

extension CurrentWeather: Decodable {
    private enum CurrentWeatherCodingKeys: String, CodingKey {
        case apparentTemp = "apparentTemperature"
        case temperature
        case uvIndex
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentWeatherCodingKeys.self)
        
        apparentTemp = try container.decode(Double.self, forKey: .apparentTemp)
        temperature = try container.decode(Double.self, forKey: .temperature)
        uvIndex = try container.decode(Int.self, forKey: .uvIndex)
    }
}
