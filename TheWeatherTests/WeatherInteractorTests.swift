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
            XCTAssertNotNil(response.temperature, "Поле temperature должно распарситься")
            XCTAssertNotNil(response.rain, "Поле rain должно распарситься")
            XCTAssertNotNil(response.thunder, "Поле thunder должно распарситься")
        case .failure:
            XCTFail("Результат не должен быть ошибкой")
        }
    }
    
    func testGetUserLocation() throws {
        //given
        let request = Weather.GetWeather.Request()
        ///Симуляция того что разрешение на получение локации получено и определена реальная локация пользователя
        provider.isUserLocationEnabled = true
        
        //when
        interactor?.fetchWeather(request: request)
        let providerRequest = provider.providerRequest
        
        //then
        XCTAssertEqual(try XCTUnwrap(providerRequest?.location), "50.0001;37.0001", "Проверяет что локация пользователя переданная в провайдер для запроса, соответствует моковым данным")
    }
    
    func testGetDefaultLocation() throws {
        //given
        let request = Weather.GetWeather.Request()
        ///Симуляция того что разрешение на получение локации НЕ получено, взята дефолтная локация,
        ///хранящаяся в публичном свойстве провайдера defaultLocation
        provider.isUserLocationEnabled = false
        
        //when
        interactor?.fetchWeather(request: request)
        let providerRequest = provider.providerRequest
        
        //then
        XCTAssertEqual(try XCTUnwrap(providerRequest?.location), "49.9808;36.2527", "Проверяет что локация пользователя переданная в провайдер для запроса, соответствует дефолтной локации")
    }
    
    func testDateForRequest() throws {
        //given
        let request = Weather.GetWeather.Request()
       
        //when
        interactor?.fetchWeather(request: request)
        let providerRequest = provider.providerRequest
        
        //then
        XCTAssertEqual(try XCTUnwrap(providerRequest?.date), "202108031200", "Проверяет что строковое представление дата переданное в провайдер для запроса, обработано интерактором правильно")
    }
}
