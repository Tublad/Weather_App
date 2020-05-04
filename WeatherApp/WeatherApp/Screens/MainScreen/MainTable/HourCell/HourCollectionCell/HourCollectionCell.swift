
import UIKit

class HourCollectionCell: UICollectionViewCell {
    
    static var reuseId: String = "HourCollectionCell"
    static var nib: UINib {
        UINib(nibName: "HourCollectionCell", bundle: nil)
    }
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconWeatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    override func prepareForReuse() {
        iconWeatherImage.image = nil
    }
    
    func configurator(with weather: Weather, about: WeatherMain, indexPath: IndexPath) {
        
        let queue = DispatchQueue.global(qos: .utility)
        if indexPath.row == 0 {
            hourLabel.text = "Now"
            tempLabel.text = Formatte.defaults.formatteCelsius(temp: about.temp) + "°"
            let urlImage = Formatte.defaults.getURL(icon: about.iconWeather)
            queue.async {
                if let data = try? Data(contentsOf: urlImage){
                    DispatchQueue.main.async {
                        self.iconWeatherImage.image = UIImage(data: data)
                    }
                }
            }
        } else {
            let hour = weather.list[indexPath.row - 1]
            hourLabel.text = Formatte.defaults.formatteTime(data: hour.date ,
                                                            timezone: weather.timezone, format: "HH")
            tempLabel.text = Formatte.defaults.formatteCelsius(temp: hour.temp) + "°"
            let urlImage = Formatte.defaults.getURL(icon: hour.weatherIcon)
            queue.async {
                if let data = try? Data(contentsOf: urlImage) {
                    DispatchQueue.main.async {
                        self.iconWeatherImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

