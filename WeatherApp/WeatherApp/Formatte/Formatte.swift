
import Foundation

class Formatte {
    
    static var defaults = Formatte()
    private init() {}
    
    let dateFormatter = DateFormatter()
    
    func formatteTime(data: Double, timezone second:Int , format: String) -> String {
        let hour = String(second / 3600)
        let date = Date(timeIntervalSince1970: data)
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+\(hour)")
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func formatteCelsius(temp: Double) -> String {
        let kelvin = 273.15
        let celsius = temp - kelvin
        let value = NSString(format: "%.0f", celsius)
        return value as String
    }
    
    func getIconWeather(icon: String) -> Data {
        var imageData = Data()
        if let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png") {
            if let data = try? Data(contentsOf: url) {
                imageData = data
            }
        }
        return imageData
    }
    
    func getURL(icon: String) -> URL {
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png") else { return URL(string: "")!}
        return url
    }
    
    func getWeek(list: [WeatherList], timezone second:Int) -> [ListDay] {
        let hour = second / 3600
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let now = dateFormatter.string(from: date as Date)
        var monTemp: [Double] = []
        var tueTemp: [Double] = []
        var wedTemp: [Double] = []
        var thuTemp: [Double] = []
        var friTemp: [Double] = []
        var satTemp: [Double] = []
        var sunTemp: [Double] = []
        var newsWeek: [ListDay] = []
        for item in list {
            let day = formatteTime(data: item.date, timezone: hour, format: "EEEE")
            
            if day == "Monday" && day != now {
                monTemp.append(item.temp)
                continue
            } else if day == "Tuesday" && day != now {
                tueTemp.append(item.temp)
                continue
            } else if day == "Wednesday" && day != now {
                wedTemp.append(item.temp)
                continue
            } else if day == "Thursday" && day != now {
                thuTemp.append(item.temp)
                continue
            } else if day == "Friday" && day != now {
                friTemp.append(item.temp)
                continue
            } else if day == "Saturday" && day != now {
                satTemp.append(item.temp)
                continue
            } else if day == "Sunday" && day != now {
                sunTemp.append(item.temp)
                continue
            }
        }
        var weekDay: [String] = []
        for item in list {
            let day = formatteTime(data: item.date, timezone: hour, format: "EEEE")
            if day == "Monday" && !weekDay.contains("Monday") && day != now {
                weekDay.append("Monday")
                if let max = monTemp.max(), let min = monTemp.min() {
                    newsWeek.append(ListDay(day: "Monday", temp: item.temp, maxTemp: max, minTemp: min, icon: item.weatherIcon, feelsLike: item.feelsLike))
                    continue
                }
                continue
            } else if day == "Tuesday" && !weekDay.contains("Tuesday") && day != now {
                weekDay.append("Tuesday")
                if let max = tueTemp.max(), let min = tueTemp.min() {
                    newsWeek.append(ListDay(day: "Tuesday", temp: item.temp, maxTemp: max, minTemp: min, icon: item.weatherIcon, feelsLike: item.feelsLike))
                    continue
                }
                continue
            } else if day == "Wednesday" && !weekDay.contains("Wednesday") && day != now {
                weekDay.append("Wednesday")
                if let max = wedTemp.max(), let min = wedTemp.min() {
                    newsWeek.append(ListDay(day: "Wednesday", temp: item.temp, maxTemp: max, minTemp: min, icon: item.weatherIcon, feelsLike: item.feelsLike))
                    continue
                }
                continue
            } else if day == "Thursday" && !weekDay.contains("Thursday") && day != now {
                weekDay.append("Thursday")
                if let max = thuTemp.max(), let min = thuTemp.min() {
                    newsWeek.append(ListDay(day: "Thursday", temp: item.temp, maxTemp: max, minTemp: min, icon: item.weatherIcon, feelsLike: item.feelsLike))
                    continue
                }
                continue
            } else if day == "Friday" && !weekDay.contains("Friday") && day != now {
                weekDay.append("Friday")
                if let max = friTemp.max(), let min = friTemp.min() {
                    newsWeek.append(ListDay(day: "Friday", temp: item.temp, maxTemp: max, minTemp: min, icon: item.weatherIcon, feelsLike: item.feelsLike))
                    continue
                }
                continue
            } else if day == "Saturday" && !weekDay.contains("Saturday") && day != now {
                weekDay.append("Saturday")
                if let max = satTemp.max(), let min = satTemp.min() {
                    newsWeek.append(ListDay(day: "Saturday", temp: item.temp, maxTemp: max, minTemp: min, icon: item.weatherIcon, feelsLike: item.feelsLike))
                    continue
                }
                continue
            } else if day == "Sunday" && !weekDay.contains("Sunday") && day != now {
                weekDay.append("Sunday")
                if let max = sunTemp.max(), let min = sunTemp.min() {
                    newsWeek.append(ListDay(day: "Sunday", temp: item.temp, maxTemp: max, minTemp: min, icon: item.weatherIcon, feelsLike: item.feelsLike))
                    continue
                }
                continue
            }
        }
        return newsWeek
    }
}
