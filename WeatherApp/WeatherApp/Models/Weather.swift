import RealmSwift

class Weather: Object, Decodable {
    
    var id = 0
    var name = ""
    var timezone = 0
    var sunrise = 0.0
    var sunset = 0.0
    var list = [WeatherList]()
    
    enum CodingKeys: String, CodingKey {
        case city
        case list
    }
    
    enum CityKeys: String, CodingKey {
        case id
        case name
        case timezone
        case sunrise
        case sunset
        case city
    }
    
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let value = try decoder.container(keyedBy: CodingKeys.self)
        if value.contains(.city) {
            let city = try value.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
            
            self.id = try city.decode(Int.self, forKey: .id)
            self.name = try city.decode(String.self, forKey: .name)
            self.timezone = try city.decode(Int.self, forKey: .timezone)
            self.sunrise = try city.decode(Double.self, forKey: .sunrise)
            self.sunset = try city.decode(Double.self, forKey: .sunset)
        }
        
        if value.contains(.list) {
            let list = try value.superDecoder(forKey: .list)
            self.list = try [WeatherList](from: list)
        }
    }
}

class WeatherList: Object, Decodable {
    
    var date = 0.0
    var temp = 0.0
    var feelsLike = 0.0
    var weatherName = ""
    var weatherIcon = ""
    var windSpeed = 0.0
    var windDeg = 0
    var pressure = 0.0
    var humidity = 0
    var dateStr = ""
    
    enum ListKeys: String, CodingKey {
        case date = "dt"
        case dateStr = "dt_txt"
        case main
        case weather
        case wind
    }
    
    enum MainKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
    
    enum WeatherKeys: String, CodingKey {
        case weatherName = "main"
        case weatherIcon = "icon"
    }
    
    enum WindKeys: String, CodingKey {
        case windSpeed = "speed"
        case windDeg = "deg"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let value = try decoder.container(keyedBy: ListKeys.self)
        
        self.date = try value.decode(Double.self, forKey: .date)
        self.dateStr = try value.decode(String.self, forKey: .dateStr)
        
        if value.contains(.main) {
            let main = try value.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
            
            self.temp = try main.decode(Double.self, forKey: .temp)
            self.feelsLike = try main.decode(Double.self, forKey: .feelsLike)
            self.pressure = try main.decode(Double.self, forKey: .pressure)
            self.humidity = try main.decode(Int.self, forKey: .humidity)
        }
        
        if value.contains(.weather) {
            var weather = try value.nestedUnkeyedContainer(forKey: .weather)
            let itemWeather = try weather.nestedContainer(keyedBy: WeatherKeys.self)
            
            self.weatherName = try itemWeather.decode(String.self, forKey: .weatherName)
            self.weatherIcon = try itemWeather.decode(String.self, forKey: .weatherIcon)
        }
        
        if value.contains(.wind) {
            let wind = try value.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
            
            self.windSpeed = try wind.decode(Double.self, forKey: .windSpeed)
            self.windDeg = try wind.decode(Int.self, forKey: .windDeg)
        }
    }
}
