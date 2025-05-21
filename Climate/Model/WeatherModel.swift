//
//  WeatherModel.swift
//  Climate
//
//  Created by shivakumar chirra on 21/05/25.
//

import Foundation


struct WeatherModel{
    let condition: Int
    let temperature: Double
    let cityName : String
    
   var temperatureString : String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName : String{
        switch condition {
        case 200..<300:
            return "cloud.bolt"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<550:
            return "sun.rain"
        case 550..<600:
            return "cloud.rain"
        case 600..<700:
            return "sun.snow"
        case 700..<800:
            return "smoke.fill"

        case 800:
            return "sunny.main"
        case 801..<804:
            return "Cloud"
        default:
            return "sun.mini.fill"
        }

    }
  

}
