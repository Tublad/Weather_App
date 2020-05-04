
import RealmSwift

protocol WeatherSource {
    func getCity() throws -> Results<WeatherRealm>
    func getAboutCity() throws -> Results<WeatherMainRealm>
    func deleteWeatherCity()
    func addWeather(weather: Weather, main: WeatherMain)
}

// MARK: Main Repository for weather app

class WeatherRepository: WeatherSource {
    
    func getCity() throws -> Results<WeatherRealm> {
        do {
            let realm = try Realm()
            return realm.objects(WeatherRealm.self)
        } catch {
            throw(error)
        }
    }
    
    func getAboutCity() throws -> Results<WeatherMainRealm> {
        do {
            let realm = try Realm()
            return realm.objects(WeatherMainRealm.self)
        } catch {
            throw(error)
        }
    }
    
    func addWeather(weather: Weather, main: WeatherMain) {
        do {
            let realm = try Realm()
            try realm.write {
                let mainRealm = WeatherMainRealm()
                mainRealm.id = main.id
                mainRealm.date = main.date
                mainRealm.iconWeather = main.iconWeather
                mainRealm.nameWeather = main.nameWeather
                mainRealm.name = main.name
                mainRealm.temp = main.temp
                mainRealm.timezone = main.timezone
                realm.add(mainRealm, update: .all)
                
                let cityRealm = WeatherRealm()
                cityRealm.id = weather.id
                cityRealm.name = weather.name
                cityRealm.timezone = weather.timezone
                cityRealm.sunrise = weather.sunrise
                cityRealm.sunset = weather.sunset
                
                weather.list.forEach { list in
                    let listRealm = ListRealm()
                    listRealm.dateStr = list.dateStr
                    listRealm.date = list.date
                    listRealm.temp = list.temp
                    listRealm.feelsLike = list.feelsLike
                    listRealm.weatherIcon = list.weatherIcon
                    listRealm.weatherName = list.weatherName
                    listRealm.windDeg = list.windDeg
                    listRealm.windSpeed = list.windSpeed
                    listRealm.humidity = list.humidity
                    listRealm.pressure = list.pressure
                    cityRealm.list.append(listRealm)
                    
                    realm.add(listRealm, update: .all)
                }
                realm.add(cityRealm, update: .all)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteWeatherCity() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
}
