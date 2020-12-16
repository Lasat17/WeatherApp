//
//  MasterSplitViewController.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 23/10/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import UIKit
import CoreData

class WeatherCardViewController: UITableViewController {
    
    let session = URLSession(configuration: .default)
    let jsonDecoder = JSONDecoder()
    let api = URLBase()
    var weatherList : WeatherList? = nil
    let iconHelper = IconHelper()
    var error : Bool = false
    
    private var weatherAppDataModelManager: WeatherAppDataModelManager!
    private var cities: [NSManagedObject]?
    
    override func viewWillAppear(_ animated: Bool) {
        weatherAppDataModelManager = WeatherAppDataModelManager()
        cities = weatherAppDataModelManager.getAllForecasts()
        if (!error && cities != nil && cities!.count > 0){
            getWeatherData()
        }
    }
    
    @IBAction func reloadData(_ sender: Any) {
        if (cities != nil && cities!.count > 0){
            getWeatherData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.weatherList != nil {
            return (weatherList?.list.count)!
        } else if error, self.cities != nil{
            return (cities?.count)!
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        if let result = self.weatherList{
            let cityName = result.list[indexPath.item].name
            let cityCountry = result.list[indexPath.item].sys.country
            cell.CityUILabel.text = "\(cityName), \(cityCountry)"
            cell.WeatherDescriptionUILabel.text = result.list[indexPath.item].weather[0].weatherDescription
            cell.WeatherDescriptionImageView.image = UIImage(named: iconHelper.iconHelper(weatherDescription: result.list[indexPath.item].weather[0].main))
            cell.CurrentTempUILabel.text = "\(Int(result.list[indexPath.item].main.temp))°"
            cell.MaxTempUILabel.text = "\(Int(result.list[indexPath.item].main.tempMax))°"
            cell.MinTempUILabel.text = "\(Int(result.list[indexPath.item].main.tempMin))°"
        } else if error, cities != nil, !cities!.isEmpty {
            let cityName = cities![indexPath.item].value(forKey: "cityName")
            let cityCountry = cities![indexPath.item].value(forKey: "country")
            cell.CityUILabel.text = "\((cityName)!), \((cityCountry)!) (Old Data)"
            if (cities![indexPath.item].value(forKey: "weatherDescription")) != nil{
                cell.WeatherDescriptionUILabel.text = "\((cities![indexPath.item].value(forKey: "weatherDescription"))!)"
                cell.WeatherDescriptionImageView.image = UIImage(named: iconHelper.iconHelper(weatherDescription: "\((cities![indexPath.item].value(forKey: "mainWeather")!))"))
                cell.CurrentTempUILabel.text = "\((cities![indexPath.item].value(forKey: "temp")!))"
                cell.MaxTempUILabel.text = "\((cities![indexPath.item].value(forKey: "tempMax")!))"
                cell.MinTempUILabel.text =  "\((cities![indexPath.item].value(forKey: "tempMin")!))"
            }
        }
        return cell
    }
    
    func getWeatherData() {
        let urlstring = api.weatherListUrl(id: cities!)
        print(urlstring)
        if let url = URL(string: urlstring){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in DispatchQueue.main.async {
                
                if error != nil{
                    self.showError(description: "Something went wrong. Try again.")
                    self.error = true
                    return
                }
                
                if let response1 = response as? HTTPURLResponse{
                    if response1.statusCode == 400 {
                        self.error = true
                        self.showError(description: "Invalid currency. Try another.")
                        return
                    }
                }
                
              
                if let weatherData = data, let weatherList1 = try? self.jsonDecoder.decode(WeatherList.self, from: weatherData){
                    self.weatherList = weatherList1
                    self.tableView.reloadData()
                    self.cities = self.weatherAppDataModelManager.updateWeather(weather: self.weatherList!.list, cityList: self.cities!)
                } else {
                    self.showError(description: "Something went wrong. Try again.")
                    self.error = true
                    if let response1 = response as? HTTPURLResponse{
                        print("\(response1.statusCode)")
                        
                    }
                }
                }})
            
            task.resume()
        }
        
    }
    
    
    func showError(description: String){
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler: {_ in self.tableView.reloadData()}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "weatherSeg"){
            if let destination = segue.destination as? ForecastViewController {
                let indexItem = (self.tableView.indexPathForSelectedRow?.item)!
                if (weatherList != nil){
                    destination.currentWeather = (weatherList?.list[indexItem])
                } else if (error && cities != nil) {
                    destination.city = (cities?[indexItem])
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if self.weatherList != nil {
                self.weatherList?.list.remove(at: indexPath.item)
            }
            self.weatherAppDataModelManager.deleteWeatherData(city: (self.cities?[indexPath.item])!)
            self.cities?.remove(at: indexPath.item)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
}
