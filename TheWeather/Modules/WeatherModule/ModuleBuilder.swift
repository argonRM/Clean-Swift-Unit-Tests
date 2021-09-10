//
//  ModuleBuilder.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import UIKit
import CoreLocation

class WeatherBuilder {
    
    public func build() -> UIViewController {
        return initController()
    }

    private func initController() -> UIViewController {
        let service = WeatherService()
        let locationManager = CLLocationManager()
        let provider = WeatherProvider(service: service, locationManager: locationManager)
        let presenter = WeatherPresenter()
        let interactor = WeatherInteractor(presenter: presenter, provider: provider)
        let viewController = WeatherViewController(interactor: interactor)
        presenter.viewController = viewController
        
        return viewController
    }
}
