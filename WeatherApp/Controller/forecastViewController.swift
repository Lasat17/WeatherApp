//
//  SplitViewController.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 23/10/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import UIKit
import CoreData

class ForecastViewController: UIViewController, UIScrollViewDelegate {
    var currentWeather : ListWeatherList?
    let iconHelper =  IconHelper()
    var city : NSManagedObject?
    let session = URLSession(configuration: .default)
    let jsonDecoder = JSONDecoder()
    let api = URLBase()
    var forecast : CityForecast?
   
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherDecriptionImageView: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    @IBOutlet weak var HumidityLvlLabel: UILabel!
    @IBOutlet weak var windLvlLabel: UILabel!
    @IBOutlet weak var cloudinessLvlLabel: UILabel!
    @IBOutlet weak var pressureLvlLabel: UILabel!
    
    @IBOutlet weak var FeelsLikeUILabel: UILabel!
    
    @IBOutlet weak var DayLabel1: UILabel!
    @IBOutlet weak var DayLabel2: UILabel!
    @IBOutlet weak var DayLabel3: UILabel!
    @IBOutlet weak var DayLabel4: UILabel!
    @IBOutlet weak var DayLabel5: UILabel!
    
    @IBOutlet weak var weatherDescriptionImageView1: UIImageView!
    @IBOutlet weak var weatherDescriptionImageView2: UIImageView!
    @IBOutlet weak var weatherDescriptionImageView3: UIImageView!
    @IBOutlet weak var weatherDescriptionImageView4: UIImageView!
    @IBOutlet weak var weatherDescriptionImageView5: UIImageView!
    
    @IBOutlet weak var maxTempLabel1: UILabel!
    @IBOutlet weak var maxTempLabel2: UILabel!
    @IBOutlet weak var maxTempLabel3: UILabel!
    @IBOutlet weak var maxTempLabel4: UILabel!
    @IBOutlet weak var maxTempLabel5: UILabel!
    
    @IBOutlet weak var minTempLabel1: UILabel!
    @IBOutlet weak var minTempLabel2: UILabel!
    @IBOutlet weak var minTempLabel3: UILabel!
    @IBOutlet weak var minTempLabel4: UILabel!
    @IBOutlet weak var minTempLabel5: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.scrollView.delegate = self
        if (currentWeather != nil){
            setUpNoError()
        } else if (city != nil){
            setUpWithError()
        }    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (currentWeather != nil){
            getForcastData()
        }
    }

    func setUpNoError(){
        cityLabel.text = "\(currentWeather!.name), \(currentWeather!.sys.country)"
        weatherDescriptionLabel.text = "\(currentWeather!.weather[0].weatherDescription)"
        weatherDecriptionImageView.image = UIImage(named: iconHelper.iconHelper(weatherDescription: currentWeather!.weather[0].main))
        currentTemp.text = "\(Int(currentWeather!.main.temp))°"
        maxTemp.text = "\(Int(currentWeather!.main.tempMax))°"
        minTemp.text = "\(Int(currentWeather!.main.tempMin))°"
        HumidityLvlLabel.text = "\(currentWeather!.main.humidity)%"
        windLvlLabel.text = "\(currentWeather!.wind.speed) m/s"
        cloudinessLvlLabel.text = "\(currentWeather!.clouds.all)%"
        pressureLvlLabel.text = "\(currentWeather!.main.pressure) hPa"
        FeelsLikeUILabel.text = "Feels like:      \(Int(currentWeather!.main.feelsLike))°"
    }
    
    func setUpWithError(){
        let cityName = city!.value(forKey: "cityName")//result.list[indexPath.item].name
        let cityCountry = city!.value(forKey: "country")
        cityLabel.text = "\((cityName)!), \((cityCountry)!) (Old Data)"
        if (city!.value(forKey: "weatherDescription")) != nil{
            weatherDescriptionLabel.text = "\((city!.value(forKey: "weatherDescription"))!)"
            weatherDecriptionImageView.image = UIImage(named: iconHelper.iconHelper(weatherDescription: "\((city!.value(forKey: "mainWeather")!))"))
            currentTemp.text = "\((city!.value(forKey: "temp")!))"
            maxTemp.text = "\((city!.value(forKey: "tempMax")!))"
            minTemp.text =  "\((city!.value(forKey: "tempMin")!))"
            HumidityLvlLabel.text = "\((city!.value(forKey: "humidity"))!)"
            windLvlLabel.text = "\((city!.value(forKey: "windSpeed"))!)"
            cloudinessLvlLabel.text = "\((city!.value(forKey: "cloudiness"))!)"
            pressureLvlLabel.text = "\((city!.value(forKey: "pressure"))!)"
            FeelsLikeUILabel.text = "\((city!.value(forKey: "pressure"))!)"
        }
    }
    
    func getForcastData() {
        if let url = URL(string: api.forcastUrl(id: currentWeather!.id)){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in DispatchQueue.main.async { [self] in
                
                if error != nil{
                    self.showError(description: "An error occurred")
                    return
                }
                
                if let response1 = response as? HTTPURLResponse{
                    if response1.statusCode == 400 {
                        self.showError(description: "Could not get the forecast data")
                        return
                    }
                }
                
                if let data1 = data, let forecast1 = try? self.jsonDecoder.decode(CityForecast.self, from: data1){
                    self.forecast = forecast1
                    dateData()
                } else {
                    self.showError(description: "Something went wrong")
                }
                }})
            task.resume()
        }
    }
    
    func showError(description: String){
        let alert = UIAlertController(title: "Error", message: "\(description).\n Please try again later ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func dateData(){
        var weatherForecast : [DateData] = []
        var ArrayIndex = 0
        
        for weather in forecast!.list {
            let date = Date(timeIntervalSince1970: TimeInterval(weather.dt)).dayOfTheWeek()
            if (weatherForecast.count != 0 && weatherForecast[ArrayIndex].day == date) {
                weatherForecast[ArrayIndex].updateData(minTemp: weather.main.tempMin, maxTemp: weather.main.tempMax, main: weather.weather[0].main)
            } else {
                weatherForecast.append(DateData.init(day: Date(timeIntervalSince1970: TimeInterval(weather.dt)).dayOfTheWeek(), minTemp: weather.main.tempMin, maxTemp: weather.main.tempMax, main: weather.weather[0].main))
                if weatherForecast.count == 1{
                } else {
                    ArrayIndex += 1
                }
            }
        }
        
        if weatherForecast[0].day.hasPrefix(Date().dayOfTheWeek()){
            weatherForecast.remove(at: 0)
        }
        
        DayLabel1.text = weatherForecast[0].day
        DayLabel2.text = weatherForecast[1].day
        DayLabel3.text = weatherForecast[2].day
        DayLabel4.text = weatherForecast[3].day
        DayLabel5.text = weatherForecast[4].day
        
        maxTempLabel1.text = "\(Int(weatherForecast[0].maxTemp))°"
        maxTempLabel2.text = "\(Int(weatherForecast[1].maxTemp))°"
        maxTempLabel3.text = "\(Int(weatherForecast[2].maxTemp))°"
        maxTempLabel4.text = "\(Int(weatherForecast[3].maxTemp))°"
        maxTempLabel5.text = "\(Int(weatherForecast[4].maxTemp))°"
        
        minTempLabel1.text = "\(Int(weatherForecast[0].minTemp))°"
        minTempLabel2.text = "\(Int(weatherForecast[1].minTemp))°"
        minTempLabel3.text = "\(Int(weatherForecast[2].minTemp))°"
        minTempLabel4.text = "\(Int(weatherForecast[3].minTemp))°"
        minTempLabel5.text = "\(Int(weatherForecast[4].minTemp))°"
        
        
        weatherDescriptionImageView1.image = UIImage(named: iconHelper.iconHelper(weatherDescription: weatherForecast[0].getMainMain()))
        weatherDescriptionImageView2.image = UIImage(named: iconHelper.iconHelper(weatherDescription: weatherForecast[1].getMainMain()))
        weatherDescriptionImageView3.image = UIImage(named: iconHelper.iconHelper(weatherDescription: weatherForecast[2].getMainMain()))
        weatherDescriptionImageView4.image = UIImage(named: iconHelper.iconHelper(weatherDescription: weatherForecast[3].getMainMain()))
        weatherDescriptionImageView5.image = UIImage(named: iconHelper.iconHelper(weatherDescription: weatherForecast[4].getMainMain()))
        
    }

}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return String(dateFormatter.string(from: self).prefix(3))
    }
}
