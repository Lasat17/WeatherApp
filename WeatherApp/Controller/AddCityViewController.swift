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
    
    private let session = URLSession(configuration: .default)
    private let jsonDecoder = JSONDecoder()
    private let api = URLBase()
    
    private var findCity : FindCity? = nil

    private var weatherAppDataModelManager: WeatherAppDataModelManager!

    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
   
    override func viewWillAppear(_ animated: Bool) {
        weatherAppDataModelManager = WeatherAppDataModelManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.isHidden = true
        self.TableView.dataSource = self
        self.TableView.delegate = self
        self.ActivityIndicator.isHidden = true
    }
    
    @IBOutlet weak var SearchCityText: UITextField!
    
    @IBAction func searchCity(_ sender: Any) {
        ActivityIndicator.isHidden = false
        ActivityIndicator.startAnimating()
        getCityData()
    }

    @IBOutlet weak var TableView: UITableView!
    
    func getCityData() {
        let city = (SearchCityText.text?.lowercased())!
        if let url = URL(string: api.findCityUrl(for: city)){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in DispatchQueue.main.async {
                
                if error != nil{
                    self.showError(description: "An error occurred")
                    return
                }
                
                if let response1 = response as? HTTPURLResponse{
                    if response1.statusCode == 400 {
                        self.showError(description: "Could not get the weather data")
                        return
                    }
                }
                
                if let data1 = data, let findCity1 = try? self.jsonDecoder.decode(FindCity.self, from: data1){
                    self.ActivityIndicator.isHidden = true
                    self.ActivityIndicator.stopAnimating()
                    self.TableView.isHidden =  false
                    self.findCity = findCity1
                    self.TableView.reloadData()
                } else {
                    self.showError(description: "Something went wrong")
                }
                }})
            task.resume()
        }
    }
    
    func showError(description: String){
        self.ActivityIndicator.isHidden = true
        let alert = UIAlertController(title: "Error", message: "\(description).\n Please try again later ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler: {_ in self.navigationController?.popViewController(animated: true)}))

        self.present(alert, animated: true, completion: nil)
    }
}

extension AddCityViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numOfCities = findCity?.list{
            return numOfCities.count
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
        if let city = findCity?.list[indexPath.item], !weatherAppDataModelManager.getCityID(cityID: "\(city.id)") {
            (self.weatherAppDataModelManager?.addCity(cityID: "\(city.id)", cityName: city.name, country: city.sys.country))!
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
