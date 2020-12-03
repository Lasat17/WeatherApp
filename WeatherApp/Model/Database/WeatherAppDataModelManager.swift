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
     
    /*
    func getCityID() -> [NSManagedObject]? {
      
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
            let predicate = NSPredicate(format: "cityID")
        request.predicate = predicate
        
            do {
                let results = try managedObjectContext.
                return results as? [NSManagedObject]
                
            } catch let error as NSError {
                print("failed: \(error)")
            }
            return nil
        }
 */
    func addCity(cityID: String?, cityName: String?, country: String?){
        let et = WeatherData(context: context)
        et.cityID = cityID
        et.cityName = cityName
        et.country = country
        appDelegate.saveContext()
    }
    
    func updateWeather(weather : ListWeatherList) {
        let et = WeatherData(context: context)
        et.temp = "\(weather.main.temp)"
        et.tempMin = "\(weather.main.tempMin)"
        et.tempMax = "\(weather.main.tempMax)"
        et.tempFeelsLike = "\(weather.main.feelsLike)"
        et.weatherDescription = weather.weather[0].weatherDescription
        et.mainWeather = weather.weather[0].main
        et.humidity = "\(weather.main.humidity)"
        et.windSpeed = "\(weather.wind.speed)"
        et.cloudiness = "\(weather.clouds)"
        et.pressure = "\(weather.main.pressure)"
        appDelegate.saveContext()
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
