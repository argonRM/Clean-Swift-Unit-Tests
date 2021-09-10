//
//  StartViewController.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 02.08.2021.
//

import UIKit
import CoreLocation

final class StartViewController: UIViewController {
 
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        handleStatus(CLLocationManager.authorizationStatus())
    }
    
    private func handleStatus(_ status: CLAuthorizationStatus) {
        guard status != .notDetermined else { return }
        navigationController?.pushViewController(WeatherBuilder().build(), animated: true)
    }
}

extension StartViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleStatus(status)
    }
}
