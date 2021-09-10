//
//  JSONParameterEncoder.swift
//  Translator2Homework
//
//  Created by user on 2/6/19.
//  Copyright © 2019 org.romanmaiboroda. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
