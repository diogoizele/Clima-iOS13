//
//  WeatherModel.swift
//  Clima
//
//  Created by Diogo Gabriel Izele on 14/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        switch conditionId {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.snow"
        case 700...799:
            return "sun.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
    var conditionTemperature: String {
        return String(format: "%.1f", temperature)
    }
}
