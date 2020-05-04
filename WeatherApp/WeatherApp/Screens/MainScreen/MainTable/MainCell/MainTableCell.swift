
import UIKit


class MainTableCell: UITableViewCell {
    
    static var reuseId: String = "MainWeatherCell"
    static var nib : UINib {
        return UINib(nibName: "MainTableCell", bundle: nil)
    }
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var aboutName: UILabel!
    @IBOutlet weak var tempName: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    func configurator(with weather: WeatherMain, indexPath: IndexPath) {
        
        cityName.text = weather.name
        aboutName.text = weather.nameWeather
        weekDayLabel.text = Formatte.defaults.formatteTime(data: weather.date,
                                                           timezone: timezone,
                                                           format: "EEEE") + " Today"
        tempName.text = Formatte.defaults.formatteCelsius(temp: weather.temp) + "°"
        let urlImage = Formatte.defaults.getURL(icon: weather.iconWeather)
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: urlImage) {
                DispatchQueue.main.async {
                    self.iconWeather.image = UIImage(data: data)
                }
            }
        }
    }
}

