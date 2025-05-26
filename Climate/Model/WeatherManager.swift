//
//  WeatherManager.swift
//  Climate
//
//  Created by shivakumar chirra on 21/05/25.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager,weather: WeatherModel)
    func didiFailWithError(error: Error)
}
struct WeatherManager {
    let apiKey = "dc38efa1eb068ff2eaea2f4c7e2eb931"
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)&appid=\(apiKey)"
        print("Fetching weather for: \(urlString)")
        performRequest(with: urlString)
        
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
      
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didiFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name

            let temperature = decodedData.main.temp
            let description = decodedData.weather[0].description
            let id = decodedData.weather[0].id
            print(id)
            print(description)
            print("temperature: \(temperature)°C")
            let weather = WeatherModel(condition: id, temperature: temperature, cityName: name)
            print(weather.condition)
            return weather
            
        } catch {
            delegate?.didiFailWithError(error: error)
            print("Parsing Error: \(error)")
            return nil
        }
    }
}

