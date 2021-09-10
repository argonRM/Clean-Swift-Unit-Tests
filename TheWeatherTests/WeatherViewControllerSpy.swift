//
//  WeatherViewControllerSpy.swift
//  TheWeatherTests
//
//  Created by Roman Maiboroda on 03.08.2021.
//

@testable import TheWeather

class WeatherViewControllerSpy: WeatherDisplayLogic {
    
    var viewControllerState: Weather.ViewControllerState?
    
    func displayState(state: Weather.ViewControllerState) {
        viewControllerState = state
    }
}
