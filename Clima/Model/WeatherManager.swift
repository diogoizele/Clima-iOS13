//
//  WeatherManager.swift
//  Clima
//
//  Created by Diogo Gabriel Izele on 05/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    private static let UNIT_FORMAT = "metric"
    private static let API_KEY = "32fd01c5d3019b0d93fae44d86836c76"
    
    private var baseUrl = {
        return "https://api.openweathermap.org/data/2.5/weather?appid=\(WeatherManager.API_KEY)&units=\(WeatherManager.UNIT_FORMAT)"
    }()
    
    public var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        if let urlEncodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            let url = "\(baseUrl)&q=\(urlEncodedCityName)"
            performRequest(url: url)
        }
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let url = "\(baseUrl)&lat=\(latitude)&lon=\(longitude)"

        performRequest(url: url)
    }
    
    
    func performRequest(url: String) {
        
        if let urlInstance = URL(string: url) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: urlInstance) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        
        task.resume()
    }
}

func parseJson(_ weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    
    do {
        let decodeData = try decoder.decode(WeatherResponse.self, from: weatherData)
        let id = decodeData.weather[0].id
        let temp = decodeData.main.temp
        let city = decodeData.name
        
        let weather = WeatherModel(conditionId: id, cityName: city, temperature: temp)
        
        return weather
    } catch {
        self.delegate?.didFailWithError(error: error)
        return nil
    }
}



}
