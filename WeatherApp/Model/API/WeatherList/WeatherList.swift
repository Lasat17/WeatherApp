//
//  WeatherList.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 11/11/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

// MARK: - WeatherList
struct WeatherList: Codable {
    let cnt: Int
    var list: [ListWeatherList]
}

// MARK: - List
struct ListWeatherList: Codable {
    let coord: CoordWeatherList
    let sys: SysWeatherList
    let weather: [WeatherWeatherList]
    let main: MainWeatherList
    let visibility: Int
    let wind: WindWeatherList
    let clouds: CloudsWeatherList
    let dt, id: Int
    let name: String
}

// MARK: - Clouds
struct CloudsWeatherList: Codable {
    let all: Int
}

// MARK: - Coord
struct CoordWeatherList: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct MainWeatherList: Codable {
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

// MARK: - Sys
struct SysWeatherList: Codable {
    let country: String
    let timezone, sunrise, sunset: Int
}

// MARK: - Weather
struct WeatherWeatherList: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct WindWeatherList: Codable {
    let speed: Double
    let deg: Int
}
