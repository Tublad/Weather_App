
class ListDay {
    var day: String
    var temp: Double
    var maxTemp: Double
    var minTemp: Double
    var icon: String
    var feelsLike: Double
    
    init(day: String, temp: Double, maxTemp: Double, minTemp: Double, icon: String, feelsLike: Double) {
        self.day = day
        self.feelsLike = feelsLike
        self.temp = temp
        self.icon = icon
        self.maxTemp = maxTemp
        self.minTemp = minTemp
    }
}
