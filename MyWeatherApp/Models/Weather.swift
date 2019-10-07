//
//  Weather.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 129//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation

struct Weather {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currentWeather: CurrentWeather
    let dailyWeatherData: DailyWeatherData
}

extension Weather: Decodable {
    private enum WeatherAPICodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case currentWeather = "currently"
        case dailyWeather = "daily"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherAPICodingKeys.self)
        
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        timezone = try container.decode(String.self, forKey: .timezone)
        currentWeather = try container.decode(CurrentWeather.self, forKey: .currentWeather)
        dailyWeatherData = try container.decode(DailyWeatherData.self, forKey: .dailyWeather)
        
    }
}
