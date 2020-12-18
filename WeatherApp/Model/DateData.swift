//
//  DateData.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 14/12/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

struct DateData {


    let day : String
    private (set) var maxTemp : Double
    private (set) var minTemp : Double
    private (set) var mainWeather : [String : Int] = [:]
    private var main = ""
    
    init(day: String, minTemp: Double, maxTemp: Double, main: String){
        self.day = day
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        mainWeather[main] = 1
    }
    
    mutating func updateData(minTemp: Double, maxTemp: Double, main: String){
        if self.minTemp > minTemp{
            self.minTemp = minTemp
        }
        if self.maxTemp < maxTemp{
            self.maxTemp = maxTemp
        }
        
        if mainWeather.keys.contains(main){
            mainWeather[main]! += 1
        } else {
            mainWeather[main] = 1
        }
        
    }
    
    func getMainMain() -> String {
        var main = ""
        var appear = 0
        
        for (weather, weatherCount) in mainWeather {
            if weatherCount > appear {
                main = weather
                appear = weatherCount
            }
        }
        
        if appear == 1 {
            main = Array(mainWeather)[4].key //at 12:00
        }
        return main
    }
}
