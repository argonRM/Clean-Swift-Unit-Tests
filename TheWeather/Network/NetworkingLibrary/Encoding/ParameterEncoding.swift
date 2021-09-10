//
//  ParameterEncoding.swift
//  Translator2Homework
//
//  Created by user on 2/6/19.
//  Copyright © 2019 org.romanmaiboroda. All rights reserved.
//

import Foundation

public typealias Parameters = [String: String]
public typealias BodyParameters = [String: Any]
public typealias BodyParametersAsData = Data

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
