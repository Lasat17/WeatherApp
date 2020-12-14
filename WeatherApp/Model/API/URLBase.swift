//
//  APIBaseKey.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 09/11/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation
import CoreData

struct URLBase {
    
    //"https://api.openweathermap.org/data/2.5/find?units=metric&q=london&appid=300e9251ab98a3f16bd8091afbaeb5eb"
    private let base_url = "https://api.openweathermap.org/data/2.5/"
    private let units_url = "?units=metric"
    private let url_Key = "&appid=300e9251ab98a3f16bd8091afbaeb5eb"
    private let url_find = "find"
    private let url_forcast = "forecast"
    private let url_weatherList = "group"
    
    func findCityUrl(for city: String) -> String{
        return "\(base_url)\(url_find)\(units_url)&q=\(city)\(url_Key)"
    }
    
    func forcastUrl(id city: Int) -> String{
        return "\(base_url)\(url_forcast)\(units_url)&id=\(city)\(url_Key)"
    }
    
    func weatherListUrl(id cities: [NSManagedObject]) -> String{
        var idlist = ""
        for (index, cityId) in cities.enumerated() {
            if index < cities.count-1 {
                idlist += "\((cityId.value(forKey: "cityID"))!),"
            } else {
                idlist += "\((cityId.value(forKey: "cityID"))!)"
            }
            
        }
        return "\(base_url)\(url_weatherList)\(units_url)&id=\(idlist)\(url_Key)"
    }
}
