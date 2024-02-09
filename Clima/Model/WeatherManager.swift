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
    
    func fetchWeather(cityName: String) {
        performRequest(url: createURL(city: cityName))
    }
    
    private func createURL(city: String) -> String {
        "https://api.openweathermap.org/data/2.5/weather?appid=\(WeatherManager.API_KEY)&q=\(city)&units=\(WeatherManager.UNIT_FORMAT)"
    }
    
    func performRequest(url: String) {
        
        if let urlInstance = URL(string: url) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: urlInstance) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    parseJson(weatherData: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(WeatherResponse.self, from: weatherData)
            print(decodeData)
            print(decodeData.weather[0].description)
        } catch {
            print(error)
        }
    }

}
