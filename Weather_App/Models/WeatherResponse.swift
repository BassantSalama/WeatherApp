

import Foundation

struct WeatherResponse: Codable {
    let id: Int 
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let icon: String
 }

struct Wind: Codable { 
    let speed: Double
    let deg: Int
}
