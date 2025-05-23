//
//  ViewController.swift
//  Climate
//
//  Created by shivakumar chirra on 20/05/25.
//

import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate, WeatherManagerDelegate {
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
     var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
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

    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
    }
}


