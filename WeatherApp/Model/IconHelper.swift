//
//  IconHelper.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 30/11/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

class IconHelper {
    
    func iconHelper(weatherDescription : String) -> String {
        switch weatherDescription.lowercased() {
        case "thunderstorm",
             "drizzle",
             "rain",
             "snow",
             "atmosphere",
             "clear",
             "clouds",
             "extreme":
            return "ic_\(weatherDescription.lowercased())"
        default:
            return "ic_launcher"
        }
    }
    
}
