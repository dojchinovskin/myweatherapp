//
//  CurrentTempView.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 179//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation
import UIKit

private enum CurrentWeatherLabel {
    case Temperature(value: Int)
    case UVIndex(value: Int)
    case RealFeel(value: Int)
    
    var text: String {
        switch self {
        case .Temperature(let value):
            return "\(value)"
        case .UVIndex(let value):
            return "UV Index: \(value)"
        case .RealFeel(let value):
            return "Real Feel: \(value) °C"
        }
    }
}

class CurrentTempView: UIView {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var continentLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var realFeelLabel: UILabel!
    @IBOutlet weak var nextForecastView: NextForecastView!
    
    func populate(weather: Weather) {
        let city = weather.timezone.split(separator: "/").last
        cityLabel.text = String(city ?? "-")
        let continent = weather.timezone.split(separator: "/").first
        continentLabel.text = String(continent ?? "-")
        let temperature = Int(weather.currentWeather.temperature.rounded())
        tempLabel.text = CurrentWeatherLabel.Temperature(value: temperature).text
        let uvIndex = weather.currentWeather.uvIndex
        uvIndexLabel.text = CurrentWeatherLabel.UVIndex(value: uvIndex).text
        let realFeel = Int(weather.currentWeather.apparentTemp.rounded())
        realFeelLabel.text = CurrentWeatherLabel.RealFeel(value: realFeel).text
        
        nextForecastView.populate(weatherData: weather.dailyWeatherData)
    }
    
}
