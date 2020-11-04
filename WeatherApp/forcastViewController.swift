//
//  SplitViewController.swift
//  WeatherApp
//
//  Created by Julie Dittmann Weimar Andersen on 23/10/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import UIKit

class ForcastViewController: UIViewController {

    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var WeatherDescriptionLabel: UILabel!
    @IBOutlet weak var WeatherDescriptionImageView: UIImageView!
    @IBOutlet weak var CurrentTempLabel: UILabel!
    @IBOutlet weak var MaxTempLabel: UILabel!
    @IBOutlet weak var MinTempLabel: UILabel!
    
    @IBOutlet weak var Day1Label: UILabel!
    @IBOutlet weak var Day2Label: UILabel!
    @IBOutlet weak var Day3Label: UILabel!
    @IBOutlet weak var Day4Label: UILabel!
    @IBOutlet weak var Day5Label: UILabel!
    
    @IBOutlet weak var Day1ImageView: UIImageView!
    @IBOutlet weak var Day2ImageView: UIImageView!
    @IBOutlet weak var Day3ImageView: UIImageView!
    @IBOutlet weak var Day4ImageView: UIImageView!
    @IBOutlet weak var Day5ImageView: UIImageView!
    
    @IBOutlet weak var Day1MaxTempLabel: UILabel!
    @IBOutlet weak var Day2MaxTempLabel: UILabel!
    @IBOutlet weak var Day3MaxTempLabel: UILabel!
    @IBOutlet weak var Day4MaxTempLabel: UILabel!
    @IBOutlet weak var Day5MaxTempLabel: UILabel!
    
    @IBOutlet weak var Day1MinTempLabel: UILabel!
    @IBOutlet weak var Day2MinTempLabel: UILabel!
    @IBOutlet weak var Day3MinTempLabel: UILabel!
    @IBOutlet weak var Day4MinTempLabel: UILabel!
    @IBOutlet weak var Day5MinTempLabel: UILabel!
    
    @IBOutlet weak var HumidityLevelLabel: UILabel!
    @IBOutlet weak var WindLevelLabel: UILabel!
    @IBOutlet weak var CloudinessLevelLabel: UILabel!
    @IBOutlet weak var PressureLevelLabel: UILabel!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DeleteCity(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
