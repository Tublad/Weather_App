
import RealmSwift

class WeatherMainRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var iconWeather = ""
    @objc dynamic var nameWeather = ""
    @objc dynamic var temp = 0.0
    @objc dynamic var timezone = 0
    @objc dynamic var date = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> WeatherMain {
        let weatherMain = WeatherMain()
        weatherMain.id = id
        weatherMain.name = name
        weatherMain.iconWeather = iconWeather
        weatherMain.nameWeather = nameWeather
        weatherMain.temp = temp
        weatherMain.timezone = timezone
        weatherMain.date = date
        return weatherMain
    }
    
}
