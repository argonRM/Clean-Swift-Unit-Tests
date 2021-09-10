//
//  WeatherProviderMock.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 03.08.2021.
//

import Foundation
import CoreLocation
@testable import TheWeather

class WeatherProviderMock: NSObject {
    
    var isUserLocationEnabled = true
    var providerRequest: Weather.GetWeather.ProviderRequest?
    var mockedUserLocation: CLLocation {
        return CLLocation(latitude: 50.0001, longitude: 37.0001)
    }
   
    func getWeather() -> WeatherResponseModel? {
        guard let data = json.data(using: .utf8) else {
            assertionFailure("Can not parse json")
            return nil
        }
        
        do {
            let weather = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
            return weather
        }
        catch {
            assertionFailure("\(error.localizedDescription)")
            return nil
        }
    }
   
    let json = "{\"r\": 35, \"t\": 29, \"sp\": 99264, \"tp\": 0, \"vis\": 24135, \"cape\": 188, \"tstm\": 4, \"acpcp\": 0, \"aptmp\": 28, \"cpofp\": -50, \"cprat\": 0, \"crain\": 3, \"dswrf\": 650, \"prmsl\": 101149, \"tdmax\": 29, \"tdmin\": 18, \"speed10\": 4.9, \"speed20\": 5, \"speed30\": 5.3, \"speed40\": 5.5, \"speed50\": 5.6, \"speed80\": 5.8, \"degree10\": 103, \"degree20\": 103, \"degree30\": 103, \"degree40\": 103, \"degree50\": 103, \"degree80\": 103}"
}

extension WeatherProviderMock: WeatherProviderProtocol {
    var nowDate: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(year: 2021, month: 08, day: 03, hour: 12, minute: 14, second: 09)
        return calendar.date(from: components)!
    }
    
    var defaultLocation: CLLocation {
        return CLLocation(latitude: 49.9808, longitude: 36.2527)
    }
    
    func getWeather(request: Weather.GetWeather.ProviderRequest, completion: @escaping (Weather.GetWeather.Result) -> Void) {
        providerRequest = request
        guard let data = json.data(using: .utf8) else {
            assertionFailure("Can not parse json")
            return
        }
        
        do {
            let weather = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
            completion(.success(weather))
        }
        catch {
            assertionFailure("\(error.localizedDescription)")
        }
    }
    
    func getUserLocation(completion: @escaping (Weather.GetLocationRequestResult) -> Void) {
        if isUserLocationEnabled {
            completion(.success(mockedUserLocation))
        } else {
            completion(.failure)
        }
    }
}

//https://gridforecast.com/api/v1/forecast/49.8479;35.6541/202108031200?api_token=wDQLqMrSaU80QzRB
