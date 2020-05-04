
import RealmSwift

class WeatherRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var timezone = 0
    @objc dynamic var sunrise = 0.0
    @objc dynamic var sunset = 0.0
    var list = List<ListRealm>()
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> Weather {
        let weather = Weather()
        weather.id = id
        weather.name = name
        weather.timezone = timezone
        weather.sunrise = sunrise
        weather.sunset = sunset
        list.forEach { value in
            let weatherList = WeatherList()
            weatherList.dateStr = value.dateStr
            weatherList.date = value.date
            weatherList.temp = value.temp
            weatherList.feelsLike = value.feelsLike
            weatherList.pressure = value.pressure
            weatherList.humidity = value.humidity
            weatherList.weatherIcon = value.weatherIcon
            weatherList.weatherName = value.weatherName
            weatherList.windDeg = value.windDeg
            weatherList.windSpeed = value.windSpeed
            weather.list.append(weatherList)
        }
        return weather
    }
    
}

class ListRealm: Object {
    
    @objc dynamic var date = 0.0
    @objc dynamic var temp = 0.0
    @objc dynamic var feelsLike = 0.0
    @objc dynamic var weatherName = ""
    @objc dynamic var weatherIcon = ""
    @objc dynamic var windSpeed = 0.0
    @objc dynamic var windDeg = 0
    @objc dynamic var pressure = 0.0
    @objc dynamic var humidity = 0
    @objc dynamic var dateStr = ""
    
    let weather = LinkingObjects(fromType: WeatherRealm.self, property: "list")
    
    override class func primaryKey() -> String? {
        return "dateStr"
    }
    
    func toModel() -> WeatherList {
        let list = WeatherList()
        list.date = date
        list.temp = temp
        list.feelsLike = feelsLike
        list.weatherName = weatherName
        list.weatherIcon = weatherIcon
        list.windDeg = windDeg
        list.windSpeed = windSpeed
        list.pressure = pressure
        list.humidity = humidity
        list.dateStr = dateStr
        
        return list
    }
}

