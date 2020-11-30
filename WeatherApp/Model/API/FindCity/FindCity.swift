//
//  File.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 09/11/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

// MARK: - FindCity
struct FindCity: Codable {
    let message, cod: String
    let count: Int
    let list: [ListFindCity]
}

// MARK: - List
struct ListFindCity: Codable {
    let id: Int
    let name: String
    let coord: CoordFindCity
    let main: MainFindCity
    let dt: Int
    let wind: WindFindCity
    let sys: SysFindCity
    let rain, snow: RainFindCity? 
    let clouds: CloudsFindCity
    let weather: [WeatherFindCity]
}

// MARK: - Clouds
struct CloudsFindCity: Codable {
    let all: Int
}

// MARK: - Coord
struct CoordFindCity: Codable {
    let lat, lon: Double
}

// MARK: - Main
struct MainFindCity: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Rain
struct RainFindCity: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Sys
struct SysFindCity: Codable {
    let country: String
}

// MARK: - Weather
struct WeatherFindCity: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct WindFindCity: Codable {
    let speed: Double
    let deg: Int
}
