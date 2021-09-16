//
//  WeatherInteractorTests.swift
//  TheWeatherTests
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import XCTest
@testable import TheWeather

class WeatherInteractorTests: XCTestCase {
    
    let provider = WeatherProviderMock()
    let presenter = WeatherPresenterSpy()
    var interactor: WeatherInteractor?

    override func setUpWithError() throws {
      
        interactor = WeatherInteractor(presenter: presenter, provider: provider)
    }

    func testFetchWeather() throws {
        //given
        let request = Weather.GetWeather.Request()
        
        //when
        interactor?.fetchWeather(request: request)
        let result = presenter.presentationResponse?.result
        
        //then
        switch try XCTUnwrap(result) {
        case .success(let response):
            XCTAssertNotNil(response.temperature, "temperature must be parsed")
            XCTAssertNotNil(response.rain, "rain must be parsed")
            XCTAssertNotNil(response.thunder, "thunder must be parsed")
        case .failure:
            XCTFail("The result must not be failure")
        }
    }
    
    func testGetUserLocation() throws {
        //given
        let request = Weather.GetWeather.Request()
        ///Simulation of the fact that permission to obtain a location is received and the real location of the user is determined
        provider.isUserLocationEnabled = true
        
        //when
        interactor?.fetchWeather(request: request)
        let providerRequest = provider.providerRequest
        
        //then
        XCTAssertEqual(try XCTUnwrap(providerRequest?.location), "50.0001;37.0001", "Checking that the user's location passed to the provider for the request matches the mock data")
    }
    
    func testGetDefaultLocation() throws {
        //given
        let request = Weather.GetWeather.Request()
        ///Simulation of the fact that permission to obtain a location is NOT received, the default location is taken,
        ///stored in the provider's public property defaultLocation
        provider.isUserLocationEnabled = false
        
        //when
        interactor?.fetchWeather(request: request)
        let providerRequest = provider.providerRequest
        
        //then
        XCTAssertEqual(try XCTUnwrap(providerRequest?.location), "49.9808;36.2527", "Checking that the user's location passed to the provider for the request matches the default location")
    }
    
    func testDateForRequest() throws {
        //given
        let request = Weather.GetWeather.Request()
       
        //when
        interactor?.fetchWeather(request: request)
        let providerRequest = provider.providerRequest
        
        //then
        XCTAssertEqual(try XCTUnwrap(providerRequest?.date), "202108031200", "Checking that the string representation of the date passed to the provider for the request is processed correctly by the interactor")
    }
}

