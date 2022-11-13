//
//  Constants.swift
//  WeatherCombineApp
//
//  Created by PaulmaX on 13.11.22.
//

import Foundation

struct Constants {
    struct URLs {
        static func weather(_ city: String) -> String {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=imperial&appid=833ce6a7614add7ac42a3c180fa6f588"
        }
    }
}
