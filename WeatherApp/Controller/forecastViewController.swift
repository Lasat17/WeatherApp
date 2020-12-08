//
//  SplitViewController.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 23/10/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import UIKit
import CoreData

class ForecastViewController: UIViewController {
    var currentWeather : ListWeatherList?
    let iconHelper =  IconHelper()
    var city : NSManagedObject?
   
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (currentWeather != nil){
            setUpNoError()
        } else if (city != nil){
            setUpWithError()
        }
    }

    func setUpNoError(){
        cityLabel.text = "\((currentWeather?.name)!), \((currentWeather?.sys.country)!)"
        weatherDescriptionLabel.text = "\((currentWeather?.weather[0].weatherDescription)!)"
        weatherDecriptionImageView.image = UIImage(named: iconHelper.iconHelper(weatherDescription: (currentWeather?.weather[0].main)!))
        currentTemp.text = String((currentWeather?.main.temp)!) + "°"
        maxTemp.text = "\(Int((currentWeather?.main.tempMax)!))°"
        minTemp.text = "\((currentWeather?.main.tempMin)!)°"
        HumidityLvlLabel.text = "\((currentWeather?.main.humidity)!)%"
        windLvlLabel.text = "\((currentWeather?.wind.speed)!) m/s"
        cloudinessLvlLabel.text = "\((currentWeather?.clouds.all)!)%"
        pressureLvlLabel.text = "\((currentWeather?.main.pressure)!) hPa"
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
        }
    }

}
