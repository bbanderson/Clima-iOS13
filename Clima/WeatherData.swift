//
//  WeatherData.swift
//  Clima
//
//  Created by HYUNHONG BYUN on 2020/04/11.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// JSON에서의 가장 상위 트리
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}


// 만약 하위 트리가 또 다른 하위 트리를 동반한다면, 그때마다 struct를 상속시킨다.
struct Main: Codable {
    let temp: Double
    let humidity: Int
}



struct Weather: Codable {
    let id: Int
}

//struct Description: Decodable {
//    let description: String
//}
