//
//  WeatherPresenterSpy.swift
//  TheWeatherTests
//
//  Created by Roman Maiboroda on 03.08.2021.
//

import Foundation
@testable import TheWeather

class WeatherPresenterSpy: WeatherPresentationLogic {
    
    var presentationResponse: Weather.GetWeather.Response?
    
    func presentWeather(response: Weather.GetWeather.Response) {
        presentationResponse = response
    }
    
    func presentProcessing() {}
}
