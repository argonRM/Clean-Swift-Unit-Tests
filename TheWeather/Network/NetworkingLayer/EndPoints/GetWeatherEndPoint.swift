//
//  GetWeatherEndPoint.swift
//

import Foundation


class GetWeatherEndPoint: EndPointType {
    
    var path: String?
    var headers: HTTPHeaders?
    var baseURL: URL
    var httpMethod: HTTPMethod
    var task: HTTPTask
    var parameters: Parameters?
    
    required init(location: String, date: String) {
    
        baseURL = URL(string: "https://gridforecast.com/api/v1/forecast/\(location)/\(date)")!//"https://gridforecast.com/api/v1/forecast/49.8479;35.6541/" + date)!
        httpMethod = HTTPMethod.get
        parameters = ["api_token": "wDQLqMrSaU80QzRB"]
        task = HTTPTask.requestParameters(bodyParameters: nil, urlParameters: parameters!, bodyParametersAlternative: nil)
    }
}
