//
//  WeatherProvider.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import Foundation
import CoreLocation

protocol WeatherProviderProtocol: AnyObject {
    func getWeather(request: Weather.GetWeather.ProviderRequest, completion: @escaping (Weather.GetWeather.Result) -> Void)
    func getUserLocation(completion: @escaping (Weather.GetLocationRequestResult) -> Void)
    var defaultLocation: CLLocation { get }
    var nowDate: Date { get }
}


class WeatherProvider: NSObject, WeatherProviderProtocol {
    private let service: WeatherService
    private var locationManager: CLLocationManager
    private var currentLocation: CLLocation?
    var defaultLocation: CLLocation {
        return CLLocation(latitude: 49.9808, longitude: 36.2527)
    }
    var nowDate: Date { return Date() }
    
    init(service: WeatherService,
         locationManager: CLLocationManager) {
        self.service = service
        self.locationManager = locationManager
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getWeather(request: Weather.GetWeather.ProviderRequest, completion: @escaping (Weather.GetWeather.Result) -> Void) {
        service.getWeather(location: request.location, date: request.date) { fetchResult in
            completion(fetchResult)
        }
    }
    
    func getUserLocation(completion: @escaping (Weather.GetLocationRequestResult) -> Void) {
            guard let currentLocation = currentLocation else {
                completion(.failure)
                return
            }
            completion(.success(currentLocation))
    }
}


extension WeatherProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        locationManager.stopUpdatingLocation()
    }
}
