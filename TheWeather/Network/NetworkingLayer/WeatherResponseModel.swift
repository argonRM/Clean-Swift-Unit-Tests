//
//  WeatherResponseModel.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import Foundation

class WeatherResponseModel: Codable {
    var temperature: Int?
    var rain: Int?
    var thunder: Int?
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "t"
        case rain = "crain"
        case thunder = "tstm"
    }
}
