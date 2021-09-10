//
//  WeatherView.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 01.08.2021.
//

import UIKit

class WeatherView: UIView {
    private lazy var rainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var thunderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 60)
        label.textColor = .white
        label.textAlignment = .right
    
        return label
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        return indicator
    }()
    
    override init(frame: CGRect = UIScreen.main.bounds) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ viewModel: Weather.ViewModel) {
        indicator.isHidden = true
        indicator.stopAnimating()
        temperatureLabel.text = viewModel.temperature
        setThunder(viewModel.thunderStorm)
        setRain(viewModel.rain)
    }
    
    func indicateProcessing() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func addSubviews() {
        addSubview(rainImageView)
        addSubview(thunderImageView)
        addSubview(temperatureLabel)
        addSubview(indicator)
    }
    
    private func makeConstraints() {
        rainImageView.translatesAutoresizingMaskIntoConstraints = false
        thunderImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        rainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        rainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        rainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        thunderImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thunderImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        thunderImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thunderImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setThunder(_ value: Weather.ViewModel.ThunderProbability) {        
        thunderImageView.image = UIImage(named: value.rawValue)
    }
    
    private func setRain(_ value: Weather.ViewModel.RainIntensity) {
        rainImageView.image = UIImage(named: value.rawValue)
    }
}
