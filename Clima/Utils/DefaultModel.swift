//
//  DefaultModel.swift
//  Clima
//
//  Created by Diogo Gabriel Izele on 08/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

class DEFAULT_MODEL {
        
    static let WEATHER = WeatherResponse(coord: Clima.Coord(lon: -52.2, lat: -28.4492), weather: [Clima.Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02n")], base: "stations", main: Clima.Main(temp: 22, feelsLike: 22.27, tempMin: 22, tempMax: 22, pressure: 1012, humidity: 77, seaLevel: 1012, grndLevel: 949), visibility: 10000, wind: Clima.Wind(speed: 1.46, deg: 84, gust: 1.42), clouds: Clima.Clouds(all: 22), dt: 1707437804, sys: Clima.Sys(country: "BR", sunrise: 1707383122, sunset: 1707430838), timezone: -10800, id: 3457817, name: "Marau", cod: 200)
}
