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
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext

      init() {
          appDelegate = UIApplication.shared.delegate as! AppDelegate
          context = appDelegate.persistentContainer.viewContext
          
      }
    
        var commitPredicate: NSPredicate?
    
    func getCityID(cityID: String) -> Bool{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
        request.predicate = NSPredicate(format: "cityID == %@", cityID)
        
        do{
            let ids = try context.fetch(request)

            if(ids.count > 0 && ids.count <= 10){
                return true
            }
            
            return false
            
        } catch let error as NSError{
            print("this bull doesn't work \(error)")
        }
        
        return false
    }

    func addCity(cityID: String?, cityName: String?, country: String?){
        let et = WeatherData(context: context)
        et.cityID = cityID
        et.cityName = cityName
        et.country = country
        appDelegate.saveContext()
    }
    
    func updateWeather(weather : [ListWeatherList], cityList: [NSManagedObject]) -> [NSManagedObject]?{
        for (index, city) in cityList.enumerated() {
            city.setValue("\(Int(weather[index].main.temp))°", forKey: "temp")
            city.setValue("\(Int(weather[index].main.tempMax))°", forKey: "tempMax")
            city.setValue("\(Int(weather[index].main.tempMin))°", forKey: "tempMin")
            city.setValue("\(Int(weather[index].main.feelsLike))°", forKey: "tempFeelsLike")
            city.setValue("\(weather[index].weather[0].weatherDescription)", forKey: "weatherDescription")
            city.setValue("\(weather[index].weather[0].main)", forKey: "mainWeather")
            city.setValue("\(weather[index].main.humidity)%", forKey: "humidity")
            city.setValue("\(weather[index].wind.speed) m/s", forKey: "windSpeed")
            city.setValue("\(weather[index].clouds.all)%", forKey: "cloudiness")
            city.setValue("\(weather[index].main.pressure)  hPa", forKey: "pressure")
            
        }
        appDelegate.saveContext()
        return getAllForecasts()
    }
    
    func deleteWeatherData(city: NSManagedObject) {
        context.delete(city)
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
}
