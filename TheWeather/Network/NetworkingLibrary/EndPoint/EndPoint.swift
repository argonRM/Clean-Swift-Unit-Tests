//
//  EndPoint.swift
//  Translator2Homework
//
//  Created by user on 2/6/19.
//  Copyright © 2019 org.romanmaiboroda. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get set } 
    var path: String? { get set }
    var httpMethod: HTTPMethod { get set }
    var task: HTTPTask { get set }
    var headers: HTTPHeaders? { get set }
    var parameters: Parameters? { get set }
}
