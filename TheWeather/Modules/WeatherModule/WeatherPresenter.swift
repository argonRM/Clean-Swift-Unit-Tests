//
//  WeatherPresenter.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import Foundation

protocol WeatherPresentationLogic {
    func presentWeather(response: Weather.GetWeather.Response)
    func presentProcessing()
}

class WeatherPresenter {
    weak var viewController: WeatherDisplayLogic?
    
    private func getViewModelFrom(_ responseModel: WeatherResponseModel) -> Weather.ViewModel {
        let viewModel = Weather.ViewModel(temperature: getTemperatureFrom(responseModel.temperature),
                                          rain: getRainIntensityFrom(responseModel.rain),
                                          thunderStorm: getRainThunderProbabilityFrom(responseModel.thunder))
        
        return viewModel
    }
    
    private func getRainIntensityFrom(_ value: Int?) -> Weather.ViewModel.RainIntensity {
        var rain: Weather.ViewModel.RainIntensity = .noRain
        switch value {
        case 1:
            rain = .light
        case 2:
            rain = .light
        case 3:
            rain = .heavy
        case 4:
            rain = .heavy
        case 5:
            rain = .heavy
        default:
            rain = .noRain
        }
        
        return rain
    }
    
    private func getRainThunderProbabilityFrom(_ value: Int?) ->  Weather.ViewModel.ThunderProbability {
        var thunder: Weather.ViewModel.ThunderProbability = .unlikely
        switch value {
        case 2:
            thunder = .probable
        case 3:
            thunder = .probable
        case 4:
            thunder = .violent
        case 5:
            thunder = .violent
        default:
            thunder = .unlikely
        }
        
        return thunder
    }
    
    private func getTemperatureFrom(_ value: Int?) ->  String {
        guard let value = value else { return "" }
        return "\(value)°C"
    }
    
    private struct TextResources {
        static let defaultError = "Something went wrong"
    }
}

extension WeatherPresenter: WeatherPresentationLogic {
    func presentProcessing() {
        viewController?.displayState(state: .processing)
    }
    
    func presentWeather(response: Weather.GetWeather.Response) {
        var state: Weather.ViewControllerState
        
        switch response.result {
        case .success(let responseModel):
            let viewModel = getViewModelFrom(responseModel)
            state = .showWeather(viewModel)
        case .failure(let error):
            state = .failure(errorText: error?.localizedDescription ?? TextResources.defaultError)
        }
        
        viewController?.displayState(state: state)
    }
}
