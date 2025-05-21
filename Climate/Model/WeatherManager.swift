//
//  WeatherManager.swift
//  Climate
//
//  Created by shivakumar chirra on 21/05/25.
//

import Foundation


protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    
}
struct WeatherManager {
    let apiKey = "dc38efa1eb068ff2eaea2f4c7e2eb931"
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)&appid=\(apiKey)"
        print("Fetching weather for: \(urlString)")
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let safeData = data {
                    let  weather = self.parseJson(weatherData: safeData)
                    self.delegate?.didUpdateWeather(weather : weather!)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
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
            print("Parsing Error: \(error)")
            return nil
        }
    }
}

