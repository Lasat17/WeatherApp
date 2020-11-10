//
//  DataModelManager.swift
//  WeatherApp
//
//  Created by Lavan Sathiyaseelan on 10/11/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataModelManager {
        var appDelegate: AppDelegate
      var context: NSManagedObjectContext

      init() {
          appDelegate = UIApplication.shared.delegate as! AppDelegate
          context = appDelegate.persistentContainer.viewContext
          
      }
    
      func addCity(cityId: Int32, cityName: String?) -> NSManagedObject{
          let et = City(context: context)
          et.cityId = cityId
          et.cityName = cityName
          appDelegate.saveContext()
          return et
          
      }
      func deleteCity(cityId: NSManagedObject, cityName: NSManagedObject){
          context.delete(cityId)
          context.delete(cityName)
          appDelegate.saveContext()
      }

      func addForecast(temp: Int32, tempMax: Int32, tempMin: Int32, weatherDescription: String?) -> NSManagedObject{
          let et = Forecast(context: context)
          et.temp = temp
          et.tempMax = tempMax
          et.tempMin = tempMin
          et.weatherDescription = weatherDescription
          appDelegate.saveContext()
          return et
      }
      func deleteForecast(temp: NSManagedObject, tempMax: NSManagedObject, tempMin: NSManagedObject, weatherDescription: NSManagedObject){
          context.delete(temp)
          context.delete(tempMax)
          context.delete(tempMin)
          context.delete(weatherDescription)
          appDelegate.saveContext()
      }
}
