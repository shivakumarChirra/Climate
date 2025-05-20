//
//  ViewController.swift
//  Climate
//
//  Created by shivakumar chirra on 20/05/25.
//

import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
       print(searchTextField.text!)
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
        //we need to give the weather report to user interface
            searchTextField.text = ""
    }

}

