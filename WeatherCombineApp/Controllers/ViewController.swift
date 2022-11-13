//
//  ViewController.swift
//  WeatherCombineApp
//
//  Created by PaulmaX on 13.11.22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    private var webservice: WebService = WebService()
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPublishers()
    }
    
    private func setupPublishers() {
        let publisher =
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,
                                                object: cityTextField)
        cancellable = publisher
            .compactMap {
                ( $0.object as! UITextField)
                    .text?
                    .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .flatMap { [unowned self] city in
                return webservice
                    .fetchWeather(city: city)
                    .catch { _ in return Just(Weather.placeholder) }
                    .map { $0 }
            }
            .sink { [unowned self] in
                if let temp = $0.temp {
                    temperatureLabel.text = "\(temp)℉"
                } else {
                    temperatureLabel.text = ""
                }
            }
    }
}
