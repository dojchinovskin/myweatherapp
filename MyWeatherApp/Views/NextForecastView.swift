//
//  NextForecastView.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 269//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation
import UIKit

class NextForecastView: UIView {
    @IBOutlet weak var nextDayLabel: UILabel!
    @IBOutlet weak var nextDayTempLabel: UILabel!
    
    @IBOutlet weak var dayAfterNextLabel: UILabel!
    @IBOutlet weak var dayAfterNextTempLabel: UILabel!
    
    @IBOutlet weak var threeDaysAfterLabel: UILabel!
    @IBOutlet weak var threeDaysAfterTempLabel: UILabel!
    
    func populate(weatherData: DailyWeatherData) {
        nextDayLabel.text = getDayAfter(value: 1)
        nextDayTempLabel.text =
            "\(Int(weatherData.data[0].temperatureMin.rounded())) °C / \(Int(weatherData.data[0].temperatureMax.rounded())) °C"
        
        dayAfterNextLabel.text = getDayAfter(value: 2)
        dayAfterNextTempLabel.text =
            "\(Int(weatherData.data[1].temperatureMin.rounded())) °C /  \(Int(weatherData.data[1].temperatureMax.rounded())) °C"
        
        threeDaysAfterLabel.text = getDayAfter(value: 3)
        threeDaysAfterTempLabel.text =
            "\(Int(weatherData.data[2].temperatureMin.rounded())) °C /  \(Int(weatherData.data[2].temperatureMax.rounded())) °C"
        
    }
    
    private func getDayAfter(value: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: value, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        switch value {
        case 1:
            let nextDay = dateFormatter.string(from: date)
            return nextDay
        case 2:
            let dayAfterNext = dateFormatter.string(from: date)
            return dayAfterNext
        case 3:
            let threeDaysAfter = dateFormatter.string(from: date)
            return threeDaysAfter
        default:
            return "No data"
        }
    }
    
}
