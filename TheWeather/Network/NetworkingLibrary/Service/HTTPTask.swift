//
//  HTTPTask.swift
//  Translator2Homework
//
//  Created by user on 2/6/19.
//  Copyright © 2019 org.romanmaiboroda. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

internal enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?, bodyParametersAlternative: BodyParameters?)
    case requestParametersAndHeader(bodyParameters: Parameters?, bodyParametersAlternative: BodyParameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?, bodyParametersAsData: Data?)
    //case requestParametersForUpload(bodyParameters: Parameters?, urlParameters: Parameters?, bodyParametersAlternative: BodyParameters?)
}
