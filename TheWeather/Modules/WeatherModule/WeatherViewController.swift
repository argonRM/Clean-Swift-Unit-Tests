//
//  WeatherViewController.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import UIKit

protocol WeatherDisplayLogic: AnyObject {
    func displayState(state: Weather.ViewControllerState)
}

class WeatherViewController: UIViewController {
    private var interactor: WeatherBusinessLogic?
    private let customView = WeatherView()
    
    init(
        interactor: WeatherBusinessLogic
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.frame = view.frame
        view = customView
      
        interactor?.fetchWeather(request: Weather.GetWeather.Request())
    }
}

extension WeatherViewController: WeatherDisplayLogic {
    func displayState(state: Weather.ViewControllerState) {
        switch state {
        case .showWeather(let viewModel):
            DispatchQueue.main.async { [weak self] in
                self?.customView.update(viewModel)
            }
        case .failure(let text):
            showError(message: text)
        case .processing:
            DispatchQueue.main.async { [weak self] in
                self?.customView.indicateProcessing()
            }
        }
    }
}
