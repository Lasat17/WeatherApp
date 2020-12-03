//
//  WeatherAppDataModelManager.swift
//  WeatherApp
//
//  Created by Lavan Sathiyaseelan on 02/12/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WeatherAppDataModelManager {
        var appDelegate: AppDelegate
      var context: NSManagedObjectContext

      init() {
          appDelegate = UIApplication.shared.delegate as! AppDelegate
          context = appDelegate.persistentContainer.viewContext
          
      }
    
    func addCity(cityID: String?, cityName: String?, country: String?) -> NSManagedObject{
        let et = WeatherData(context: context)
        et.cityID = cityID
        et.cityName = cityName
        et.country = country
        appDelegate.saveContext()
        return et
    }
    
    func addWeather(temp: String?, tempMin: String?, tempMax: String?, tempFeelsLike: String?, weatherDescription:  String?, mainWeather: String?) -> NSManagedObject {
        let et = WeatherData(context: context)
        et.temp = temp
        et.tempMin = tempMin
        et.tempMax = tempMax
        et.tempFeelsLike = tempFeelsLike
        et.weatherDescription = weatherDescription;
        et.mainWeather = mainWeather
        appDelegate.saveContext()
        return et
    }
    
    func addWeatherInfo(humidity: String?, windSpeed: String?, cloudiness: String?, pressure: String?) -> NSManagedObject {
        let et = WeatherData(context: context)
        et.humidity = humidity
        et.windSpeed = windSpeed
        et.cloudiness = cloudiness
        et.pressure = pressure
        appDelegate.saveContext()
        return et
    }
    func deleteWeatherData(
        cityID: NSManagedObject, cityName: NSManagedObject, country: NSManagedObject, temp: NSManagedObject, tempMin: NSManagedObject, tempMax: NSManagedObject, tempFeelsLike: NSManagedObject, weatherDescription: NSManagedObject, mainWeather: NSManagedObject, humidity: NSManagedObject, windSpeed: NSManagedObject, cloudiness: NSManagedObject,pressure: NSManagedObject) {
        
        context.delete(cityID)
        context.delete(cityName)
        context.delete(country)
        context.delete(temp)
        context.delete(tempMin)
        context.delete(tempMax)
        context.delete(tempFeelsLike)
        context.delete(weatherDescription)
        context.delete(mainWeather)
        context.delete(humidity)
        context.delete(windSpeed)
        context.delete(cloudiness)
        context.delete(pressure)
        appDelegate.saveContext()
        
    }
    func getAllForecasts() -> [NSManagedObject]? {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")

            do {
                let results = try context.fetch(request)
                return results as? [NSManagedObject]
            } catch {
                print("failed: \(error)")
            }
            return nil
        }
/*
      func deleteForecast(temp: NSManagedObject, tempMax: NSManagedObject, tempMin: NSManagedObject, weatherDescription: NSManagedObject){
          context.delete(temp)
          context.delete(tempMax)
          context.delete(tempMin)
          context.delete(weatherDescription)
          appDelegate.saveContext()
      }
 */
}
