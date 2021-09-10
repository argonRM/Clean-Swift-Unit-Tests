//
//  Router.swift
//  Translator2Homework
//
//  Created by user on 2/6/19.
//  Copyright © 2019 org.romanmaiboroda. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?
  
    private var session = URLSession(configuration: URLSessionConfiguration.default)
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
        
    }
    
    func requestUpload(_ route: EndPoint, localURL: URL, completion: @escaping NetworkRouterCompletion) {
        do {
            let request = try self.buildRequest(from: route)
            let  configUpload = URLSessionConfiguration.default
            session = URLSession(configuration: configUpload)
            task = session.uploadTask(with: request, fromFile: localURL, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func requestDownload(_ route: EndPoint, completion: @escaping (_ localUrl: URL?,_ response: URLResponse?,_ error: Error?)->()) {
        do {
            let request = try self.buildRequest(from: route)
            let  configUpload = URLSessionConfiguration.default
            session = URLSession(configuration: configUpload)
            task = session.downloadTask(with: request, completionHandler: { (url, response, error) in
                completion(url, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request: URLRequest
        if let path = route.path {
             request = URLRequest(url: route.baseURL.appendingPathComponent(path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        } else {
            request = URLRequest(url: route.baseURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        }
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.allHTTPHeaderFields = route.headers
                if route.headers != nil {
                    //request.addValue("application/json", forHTTPHeaderField: "Content-type")
                }
                
            case .requestParameters(let bodyparameters, let urlParameters, let bodyParametersAlternative):
                request.allHTTPHeaderFields = route.headers
                try self.configureParameters(bodyParameters: bodyparameters, bodyParametersAlternative: bodyParametersAlternative,  bodyParametersAsData: nil, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeader(let bodyParameters, let bodyParametersAlternative, let urlParameters, let additionalHeaders, let bodyParametersAsData):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                request.allHTTPHeaderFields = route.headers
                try self.configureParameters(bodyParameters: bodyParameters, bodyParametersAlternative: bodyParametersAlternative,  bodyParametersAsData: bodyParametersAsData, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    
    fileprivate func configureParameters(bodyParameters: Parameters?, bodyParametersAlternative: BodyParameters?, bodyParametersAsData: Data?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
            if let bodyParametersAlternative = bodyParametersAlternative {
                do {
                    let data  = try JSONSerialization.data(withJSONObject: bodyParametersAlternative, options: [])
                    request.httpBody = data
                }
                catch {
                    print(error)
                }
            } else if let bodyParametersAsData = bodyParametersAsData {
                request.httpBody = bodyParametersAsData
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
