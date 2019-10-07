//
//  AddViewController.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 309//19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol AddViewControllerDelegate: class {
    func updateLocation(weather: Weather)
}

class AddViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longituteTextField: UITextField!
    
    weak var delegate: AddViewControllerDelegate?
    
    @IBAction func forecastButtonPressed(_ sender: Any) {
        if let latitude = latitudeTextField.text, let longitude = longituteTextField.text {
            getWeatherFor(latitude: latitude, longitude: longitude)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getCoordinatesButtonPressed(_ sender: Any) {
        if let address = searchTextField.text {
            getCoordinateFrom(address: address)
        }
    }
    
    private func getWeatherFor(latitude: String, longitude: String) {
        NetworkManager.shared.getWeather(coordinates: "\(latitude),\(longitude)") { [weak self] (weather, error) in
            if let error = error {
                print(error)
            }
            if let weather = weather {
                DispatchQueue.main.async {
                    self?.delegate?.updateLocation(weather: weather)
                }
            }
        }
    }
    
    private func getCoordinateFrom(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemark, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let placemark = placemark {
                if let coordinate = placemark.first?.location?.coordinate {
                    self.latitudeTextField.text = String(coordinate.latitude)
                    self.longituteTextField.text = String(coordinate.longitude)
                }
            }
        }
    }
    
}
