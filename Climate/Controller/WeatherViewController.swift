//
//  ViewController.swift
//  Climate
//
//  Created by shivakumar chirra on 20/05/25.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController,UITextFieldDelegate, WeatherManagerDelegate {
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
     var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
     
        searchTextField.resignFirstResponder()
        searchTextField.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Enter City Name"
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
            searchTextField.text = ""
    }

    func didUpdateWeather(_ weatherManager:WeatherManager,weather: WeatherModel) {
        DispatchQueue.main.sync {
            self.temperatureLabel.text = weather.temperatureString
            conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    func didiFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - cllocation manager delegarte

extension WeatherViewController:CLLocationManagerDelegate{
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       if let location = locations.last{
           locationManager.stopUpdatingLocation( )
           let lat = location.coordinate .latitude
           let lon = location.coordinate .longitude
           weatherManager.fetchWeather(latitude: lat, longitude: lon)
           print(lon)
           
       }
    }
    func locationManager(_ manager: CLLocationManager,  didFailWithError error: Error) {
        print(error)
    }
}
