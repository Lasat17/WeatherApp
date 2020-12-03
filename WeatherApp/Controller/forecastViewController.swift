//
//  SplitViewController.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 23/10/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    var currentWeather : ListWeatherList?
    let iconHelper =  IconHelper()
    
    let notAv = "N/A"
   
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
        
    }

}
