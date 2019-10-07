//
//  HomeViewController.swift
//  MyWeatherApp
//
//  Created by Nikola Dojchinovski on 13/8/19.
//  Copyright © 2019 Nikola. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var currentTempView: CurrentTempView!
    
    var weather: Weather?

    override func viewDidLoad() {
        super.viewDidLoad()
        // location for Skopje
        let location = "42.0050,21.4408"
        getWeatherFor(coordinates: location)
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let addViewController = self.storyboard?.instantiateViewController(withIdentifier: "addViewControllerId") as? AddViewController else { fatalError("ViewController not found") }
        addViewController.delegate = self
        self.navigationController?.pushViewController(addViewController, animated: true)
    }
    
    private func getWeatherFor(coordinates: String) {
        NetworkManager.shared.getWeather(coordinates: coordinates) { [weak self] (weather, error) in
            if let weather = weather {
                DispatchQueue.main.async {
                    self?.currentTempView.populate(weather: weather)
                }
            }
        }
    }
    
}

extension HomeViewController: AddViewControllerDelegate {
    func updateLocation(weather: Weather) {
        DispatchQueue.main.async {
            self.currentTempView.populate(weather: weather)
        }
    }
}

