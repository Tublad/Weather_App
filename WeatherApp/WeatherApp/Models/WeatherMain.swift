
import RealmSwift

class WeatherMain: Object, Decodable {
    
    var id = 0
    var name = ""
    var iconWeather = ""
    var nameWeather = ""
    var temp = 0.0
    var timezone = 0
    var date = 0.0
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case date = "dt"
        case timezone
        case id
        case name
    }
    
    enum WeatherKeys: String, CodingKey {
        case iconWeather = "icon"
        case nameWeather = "description"
    }
    
    enum MainKeys: String, CodingKey {
        case temp
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let value = try decoder.container(keyedBy: CodingKeys.self)
        
        self.date = try value.decode(Double.self, forKey: .date)
        self.id = try value.decode(Int.self, forKey: .id)
        self.name = try value.decode(String.self, forKey: .name)
        self.timezone = try value.decode(Int.self, forKey: .timezone)
        
        if value.contains(.main) {
            let main = try value.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
            
            self.temp = try main.decode(Double.self, forKey: .temp)
        }
        
        if value.contains(.weather) {
            var weather = try value.nestedUnkeyedContainer(forKey: .weather)
            let itemWeather = try weather.nestedContainer(keyedBy: WeatherKeys.self)
            
            self.nameWeather = try itemWeather.decode(String.self, forKey: .nameWeather)
            self.iconWeather = try itemWeather.decode(String.self, forKey: .iconWeather)
        }
    }
    
}
