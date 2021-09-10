//
//  WeatherPresenterTests.swift
//  TheWeatherTests
//
//  Created by Roman Maiboroda on 03.08.2021.
//

import XCTest
@testable import TheWeather

class WeatherPresenterTests: XCTestCase {
    
    let provider = WeatherProviderMock()
    let presenter = WeatherPresenter()
    let viewController = WeatherViewControllerSpy()

    override func setUpWithError() throws {
        presenter.viewController = viewController
    }
    
    func testFetchWeather() throws {
        //given
        let result: Weather.GetWeather.Result = .success(try XCTUnwrap(provider.getWeather()))
        let response = Weather.GetWeather.Response(result: result)
        
        //when
        presenter.presentWeather(response: response)
        
        //then
        switch try XCTUnwrap(viewController.viewControllerState) {
        case .showWeather(let viewModel):
            XCTAssertEqual(viewModel.temperature, "29°C")
            XCTAssertEqual(viewModel.rain, .heavy)
            XCTAssertEqual(viewModel.thunderStorm, .violent)
        default:
            XCTFail("Стейт выбран неправильно, должен быть showWeather")
        }
    }
}
