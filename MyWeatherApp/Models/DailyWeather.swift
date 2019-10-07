//
//  DailyWeather.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 310//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

struct DailyWeatherData {
    let data: [DailyWeather]
}

extension DailyWeatherData: Decodable {
    private enum DailyWeatherDataCodingKey: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DailyWeatherDataCodingKey.self)
        
        data = try container.decode([DailyWeather].self, forKey: .data)
    }
}

struct DailyWeather {
    let temperatureMax: Double
    let temperatureMin: Double
    let icon: String
}

extension DailyWeather: Decodable {
    private enum DailyWeatherCodingKeys: String, CodingKey {
        case temperatureMax
        case temperatureMin
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DailyWeatherCodingKeys.self)
        
        temperatureMax = try container.decode(Double.self, forKey: .temperatureMax)
        temperatureMin = try container.decode(Double.self, forKey: .temperatureMin)
        icon = try container.decode(String.self, forKey: .icon)
    }
}

