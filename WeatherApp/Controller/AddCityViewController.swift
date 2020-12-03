//
//  File.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 09/11/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddCityViewController : UIViewController{
    
    let session = URLSession(configuration: .default)
    let jsonDecoder = JSONDecoder()
    let api = URLBase()
    
    var findCity : FindCity? = nil
    
    //database kode
    private var weatherAppDataModelManager: WeatherAppDataModelManager!
    private var forecasts: [NSManagedObject]?
    
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.isHidden = true
        self.TableView.dataSource = self
        self.TableView.delegate = self
        
        self.ActivityIndicator.isHidden = true
        weatherAppDataModelManager = WeatherAppDataModelManager()
        forecasts = weatherAppDataModelManager.getAllForecasts()
    }
    
    @IBOutlet weak var SearchCityText: UITextField!
    
    @IBAction func searchCity(_ sender: Any) {
        ActivityIndicator.isHidden = false
        ActivityIndicator.startAnimating()
        getCityData()
    }
    
/*
    override func viewWillAppear(_ animated: Bool) {
        weatherAppDataModelManager = WeatherAppDataModelManager()
        forecasts = weatherAppDataModelManager.getAllForecasts()
    }
    */
    @IBOutlet weak var TableView: UITableView!
    
    //func getCityData(for city: String)
    func getCityData() {
        let city = (SearchCityText.text?.lowercased())!
        if let url = URL(string: api.findCityUrl(for: city)){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in DispatchQueue.main.async {
                
                if error != nil{
                    self.showError(description: "Something went wrong. Try again.")
                    print("1")
                    return
                }
                
                if let response1 = response as? HTTPURLResponse{
                    if response1.statusCode == 400 {
                        self.showError(description: "Invalid currency. Try another.")
                        print("2")
                        return
                    }
                }
                
              
                if let data1 = data, let findCity1 = try? self.jsonDecoder.decode(FindCity.self, from: data1){
                    self.ActivityIndicator.isHidden = true
                    self.ActivityIndicator.stopAnimating()
                    self.TableView.isHidden =  false
                    self.findCity = findCity1
                    self.TableView.reloadData()
                    print("hello")
                } else {
                    self.showError(description: "Something went wrong. Try again.")
                    
                    if let response1 = response as? HTTPURLResponse{
                        print("\(response1.statusCode)")
                        
                    }

                }
                
                }})
            
            task.resume()
        }
        
    }
    
    
    func showError(description: String){
        self.ActivityIndicator.isHidden = true
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler: {_ in self.navigationController?.popViewController(animated: true)}))
        
        self.present(alert, animated: true, completion: nil)
    }

}


extension AddCityViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.findCity != nil {
            print("nub of item")
            return (findCity?.list.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! AddCityTableViewCell
        if let resultCities = self.findCity {
            let cityName = resultCities.list[indexPath.item].name
            let cityCountry = resultCities.list[indexPath.item].sys.country
            cell.AddCItyNameUILabel.text = "\(cityName), \(cityCountry)"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.TableView.deselectRow(at: indexPath, animated: true)
        print("1")
        
       let forecast = (self.weatherAppDataModelManager?.addCity(cityID: "\((findCity?.list[indexPath.item].id)!)", cityName: findCity?.list[indexPath.item].name, country: findCity?.list[indexPath.item].sys.country))!
        print("2")
        self.forecasts!.append(forecast)
        print("3")
        self.navigationController?.popToRootViewController(animated: true)
   
        
        
    }
    
}

