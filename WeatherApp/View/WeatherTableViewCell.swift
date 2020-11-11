//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Lavan Sathiyaseelan on 26/10/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation
import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var CityUILabel: UILabel!
    @IBOutlet weak var WeatherDescriptionUILabel: UILabel!
    @IBOutlet weak var WeatherDescriptionImageView: UIImageView!
    @IBOutlet weak var CurrentTempUILabel: UILabel!
    @IBOutlet weak var MaxTempUILabel: UILabel!
    @IBOutlet weak var MinTempUILabel: UILabel!
}
