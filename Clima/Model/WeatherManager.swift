//
//  WeatherManager.swift
//  Clima
//
//  Created by Diogo Gabriel Izele on 05/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    
    private static let UNIT_FORMAT = "metric"
    private static let API_KEY = "32fd01c5d3019b0d93fae44d86836c76"

    private var url = ""
    
    init() {
        self.setUrl(city: "Marau")
    }
    
    mutating func fetchWeather(cityName: String) {
        self.setUrl(city: cityName)
        
        performRequest(url: url)
    }
    
    private mutating func setUrl(city: String) {
        self.url = "https://api.openweathermap.org/data/2.5/weather?appid=\(WeatherManager.API_KEY)&q=\(city)&units=\(WeatherManager.UNIT_FORMAT)"
    }
    
    func performRequest(url: String) {
        
        if let urlInstance = URL(string: url) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: urlInstance, completionHandler: self.handle)
            
            task.resume()
            
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data{
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString!)
        }
    }
}
