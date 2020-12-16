//
//  DateData.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 14/12/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

class DateData {


    let day : String
    var maxTemp : Double
    var minTemp : Double
    var mainWeather : [String : Int] = [:]
    
    init(day: String, minTemp: Double, maxTemp: Double, main: String){
        self.day = day
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        mainWeather[main] = 1
    }
    
    func updateData(minTemp: Double, maxTemp: Double, main: String){
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
        return main
    }
}
