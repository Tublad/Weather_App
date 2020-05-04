
import UIKit

class WeekTableCell: UITableViewCell {
    
    static var reuseId: String = "WeekCell"
    static var nib: UINib {
        UINib(nibName: "WeekTableCell", bundle: nil)
    }
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var iconWeatherImage: UIImageView!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var nightTempLabel: UILabel!
    
    override func prepareForReuse() {
        iconWeatherImage.image = nil
    }
    
    func configurator(with weather: ListDay, indexPath: IndexPath) {
        if indexPath.row < 4 {
            lineView.backgroundColor = .white
            lineView.alpha = 0.8
            weekDayLabel.text = weather.day
            dayTempLabel.text = Formatte.defaults.formatteCelsius(temp: weather.maxTemp) + "°"
            nightTempLabel.text = Formatte.defaults.formatteCelsius(temp: weather.minTemp) + "°"
            let urlImage = Formatte.defaults.getURL(icon: weather.icon)
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = try? Data(contentsOf: urlImage) {
                    DispatchQueue.main.async {
                        self.iconWeatherImage.image = UIImage(data: data)
                    }
                }
            }
        } else {
            lineView.backgroundColor = .clear
            weekDayLabel.text = weather.day
            dayTempLabel.text = Formatte.defaults.formatteCelsius(temp: weather.maxTemp) + "°"
            nightTempLabel.text = Formatte.defaults.formatteCelsius(temp: weather.minTemp) + "°"
            let urlImage = Formatte.defaults.getURL(icon: weather.icon)
            let queue = DispatchQueue.global(qos: .utility)
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

