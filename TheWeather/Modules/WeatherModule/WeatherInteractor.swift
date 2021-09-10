//
//  WeatherInteractor.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import CoreLocation

protocol WeatherBusinessLogic: AnyObject {
    func fetchWeather(request: Weather.GetWeather.Request)
}

class WeatherInteractor {
    private let presenter: WeatherPresentationLogic
    private let provider: WeatherProviderProtocol
   
    init(presenter: WeatherPresentationLogic,
         provider: WeatherProviderProtocol
    ) {
        self.presenter = presenter
        self.provider = provider
        
    }
    
    private func getLocation(completion: @escaping (CLLocation) -> Void) {
        provider.getUserLocation { fetchResult in
            switch fetchResult {
            case .success(let currentLocation):
                completion(currentLocation)
            case .failure:
                completion(self.provider.defaultLocation)
            }
        }
    }
    
    private func dateToString(_ date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHH"
        var dateString = dateFormatter.string(from: date)
        dateString = dateString + "00"
        return dateString
    }
    
    private func locationToString(_ location: CLLocation) -> String {
        let coordinate = location.coordinate
        let locationString = String(coordinate.latitude) + ";" + String(coordinate.longitude)
        return locationString
    }
}

extension WeatherInteractor: WeatherBusinessLogic {
    func fetchWeather(request: Weather.GetWeather.Request) {
        presenter.presentProcessing()
        
        getLocation { [weak self] location in
            guard let self = self else { return }
            guard let stringDate = self.dateToString(self.provider.nowDate) else {
                return
            }
            
            let stringLocation = self.locationToString(location)
            let providerRequest = Weather.GetWeather.ProviderRequest(location: stringLocation, date: stringDate)
            
            self.provider.getWeather(request: providerRequest) { fetchResult in
                var response: Weather.GetWeather.Response
                switch fetchResult {
                case .success(let responseModel):
                    response = .init(result: .success(responseModel))
                case .failure(let error):
                    response = .init(result: .failure(error))
                }
                
                self.presenter.presentWeather(response: response)
            }
        }
    }
}
