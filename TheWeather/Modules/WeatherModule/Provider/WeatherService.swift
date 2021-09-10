//
//  WeatherService.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import Foundation

class WeatherService {
    func getWeather(location: String, date: String, completion: @escaping (Weather.GetWeather.Result) -> Void) {
        let endPoint = GetWeatherEndPoint(location: location, date: date)
        let router = Router<GetWeatherEndPoint>()
        router.request(endPoint) { (data, response, error) in
            guard error == nil else {
                print("There was an error with your request: \(String(describing: error))")
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code = \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                completion(.failure(nil))
                return
            }
            }
            guard let responsedData = data else {
                completion(.failure(nil))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responsedObject = try decoder.decode(WeatherResponseModel.self, from: responsedData)
                completion(.success(responsedObject))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

