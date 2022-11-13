//
//  Weather.swift
//  WeatherCombineApp
//
//  Created by PaulmaX on 13.11.22.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp:       Double?
    let humidity:   Double?
    
    static var placeholder: Weather {
        return Weather(temp: nil, humidity: nil)
    }
}
