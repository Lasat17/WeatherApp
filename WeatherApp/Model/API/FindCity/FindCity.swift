//
//  File.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 09/11/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

struct FindCity: Codable {
    public let message, cod: String
    public let count: Int
    public let list: [List]
}

struct List: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let main: Main
    let dt: Int
    let wind: Wind
    let sys: Sys
    let rain, snow: JSONNull?
    let clouds: Clouds
    let weather: [Weather]
}

struct Clouds: Codable {
    public let all: Int
}

struct Coord: Codable {
    public let lat, lon: Double
}

struct Main: Codable {
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

struct Sys: Codable {
    let country: String
}

struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
