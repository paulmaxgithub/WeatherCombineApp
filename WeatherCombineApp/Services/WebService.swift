//
//  WebService.swift
//  WeatherCombineApp
//
//  Created by PaulmaX on 13.11.22.
//

import Foundation
import Combine

final class WebService {
    
    public func fetchWeather(city: String) -> AnyPublisher<Weather, Error> {
        guard let url = URL(string: Constants.URLs.weather(city)) else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map {$0.main}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
