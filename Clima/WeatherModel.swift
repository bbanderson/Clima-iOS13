//
//  WeatherModel.swift
//  Clima
//
//  Created by HYUNHONG BYUN on 2020/04/12.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temparature: Double
    
    var temparatureOneDecimal: String {
        return String(format:"%.1f", temparature)
    }
    
    var weatherName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud.fill"
        }
    }
    
//    func getWeatherID(_ weatherID: Int) -> String {
//
//    }
}
