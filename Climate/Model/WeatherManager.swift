//
//  WeatherManager.swift
//  Climate
//
//  Created by shivakumar chirra on 21/05/25.
//

import Foundation

struct WeatherManager {
    // i need to change the codeafter my api key update
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?"
    let apiId = "appid=dc38efa1eb068ff2eaea2f4c7e2eb931&q=metric"
    
    
    func fetchWeather(cityName :String) {
        let urlString = "\(weatherUrl)q=\(cityName)&\(apiId)"
        print(urlString)
    }
}
