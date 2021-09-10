//
//  WeatherDataFlow.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import Foundation
import CoreLocation

enum Weather {
    
    enum GetWeather {
        struct Request {
        }
        
        enum Result {
            case success(WeatherResponseModel)
            case failure(Error?)
        }
        
        struct Response {
            let result: Result
        }
        
        struct ProviderRequest {
            let location: String
            let date: String
        }
    }
    
    enum GetLocationRequestResult {
        case success(CLLocation)
        case failure
    }
    
    struct ViewModel {
        let temperature: String
        let rain: RainIntensity
        let thunderStorm: ThunderProbability
        
        init(temperature: String, rain: RainIntensity, thunderStorm: ThunderProbability) {
            self.temperature = temperature
            self.rain = rain
            self.thunderStorm = thunderStorm
        }
        
        enum RainIntensity: String {
            case noRain
            case light
            case heavy
        }
        
        enum ThunderProbability: String {
            case unlikely
            case probable
            case violent
        }
    }
    
    enum ViewControllerState {
        case showWeather(_ viewModel: ViewModel)
        case processing
        case failure(errorText: String)
    }
}
