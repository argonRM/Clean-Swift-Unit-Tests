//
//  UIViewController + Extension.swift
//  TheWeather
//
//  Created by Roman Maiboroda on 02.08.2021.
//

import UIKit

extension UIViewController {
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let presenter = self else { return }
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            presenter.present(alert, animated: true, completion: nil)
        }
    }
}
