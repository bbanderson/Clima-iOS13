//
//  WeatherManager.swift
//  Clima
//
//  Created by HYUNHONG BYUN on 2020/04/10.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=2ddad7f301e34d29f302e40dd892bc4a&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSEssion
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            //                let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weatherID = decodedData.weather[0].id
            let weatherModel = WeatherModel(conditionId: weatherID, cityName: name, temparature: temp)
//            let weatherIcon = weatherModel.getWeatherID(weatherID)
//            print(weatherIcon)
            return weatherModel
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    //    func handle(data: Data?, response: URLResponse?, error: Error?) {
    //
    //    }
    
}

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

extension WeatherManager {
    func fetchWeather(latitude: String, longitude: String) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
}
