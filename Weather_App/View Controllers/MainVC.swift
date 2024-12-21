import Foundation
import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var choseCityButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    var cityID = 360630
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        choseCityButton.layer.cornerRadius = 15
        NotificationCenter.default.addObserver(self, selector: #selector(cityNameChanged), name: NSNotification.Name("cityChanged"), object: nil)
        
        fetchWeatherData()
    }
    
    func fetchWeatherData() {
        let apiKey = "00a8084599ad81a54baba39b85a170a0"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?id=\(cityID)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL \(urlString)")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                print("data \(response)")
                
                let temp = response.main.temp
                let humidity = response.main.humidity
                let wind = response.wind.speed
                
                DispatchQueue.main.async {
                    self.humidityLabel.text = "\(humidity)%"
                    self.tempLabel.text = "\(temp)°C"
                    self.windLabel.text = "\(wind)m/s"
                }
            } catch {
                print("Error \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    @objc func cityNameChanged(notification: Notification) {
        if let city = notification.userInfo?["city"] as? City {
            cityNameLabel.text = city.name
            cityID = city.id
            fetchWeatherData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

    

