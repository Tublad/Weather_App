
import UIKit
import RealmSwift

enum CellTypes {
    case main
    case betweenSection
    case listHour
    case betweenSections
    case listDay(item: ListDay)
}

class WeatherViewController: UIViewController {
    
    private let weatherService = WeatherService()
    private var weather = [Weather]()
    private var weatherMain = [WeatherMain]()
    var cityName = String()
    static let reuseId: String = "WeatherList"
    private let database = WeatherRepository()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        flow.scrollDirection = .horizontal
        return collectionView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.view.bounds)
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let now = dateFormatter.string(from: date as Date)
        if let hour = Int(now) {
            if hour > 6 && hour < 22 {
                imageView.image = UIImage(named: "day")
            } else {
                imageView.image = UIImage(named: "night")
            }
        }
        return imageView
    }()
    
    private var weekList: [CellTypes] = []
    private var models: [[CellTypes]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(imageView)
        setupCollectionView()
        getWeatherFromDatabase()
        getWeatherFromApi()
    }
    
    func getWeatherFromDatabase() {
        do {
            weekList.removeAll()
            models.removeAll()
            weather = try Array(database.getCity()).map{ $0.toModel() }
            weatherMain = try Array(database.getAboutCity()).map{ $0.toModel() }
            for city in weather {
                weekList.append(contentsOf: Formatte.defaults.getWeek(list: city.list, timezone: city.timezone).map { CellTypes.listDay(item: $0) })
            }
            self.addContent()
            self.collectionView.reloadData()
        } catch {
            print(error)
        }
    }
    
    func getWeatherFromApi() {
        weatherService.getWeatherMain(city: cityName) { [weak self] weatherMain in
            switch weatherMain {
            case .success(let main):
                self?.weatherService.getWeather(city: main.name) { [weak self] weather in
                    switch weather {
                    case .success(let city):
                        guard city.id != 0 else { return }
                        self?.database.deleteWeatherCity()
                        self?.database.addWeather(weather: city, main: main)
                        self?.getWeatherFromDatabase()
                    case .failure(let error):
                        print("What is going???? o_O" + error.localizedDescription)
                    }
                }
            case .failure( _):
                let alert = UIAlertController(title: "Error", message: "Sorry, our server is currently not available. Try again in a few minutes.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                alert.addAction(action)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func addContent() {
        models.append([.main])
        models.append([.betweenSection])
        models.append([.listHour])
        models.append([.betweenSections])
        models.append(weekList)
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
    }
}
// MARK: Создания размера ячейки коллекции

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width, height: view.bounds.height)
    }
}
// MARK: Создание Delegate и DataSource для главной коллекции

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseId, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        cell.tableView.delegate = self
        cell.tableView.dataSource = self
        cell.tableView.reloadData()
        
        return cell
    }
}
// MARK: Расширение для TableView, которая находиться в ячейки главное коллекции

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = models[indexPath.section][indexPath.row]
        switch row {
        case .main:
            return 300
        case .betweenSection:
            return 2
        case .listHour:
            return 90
        case .betweenSections:
            return 2
        case .listDay:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = models[indexPath.section][indexPath.row]
        
        switch row {
        case .main:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableCell.reuseId, for: indexPath) as? MainTableCell else { return UITableViewCell() }
            
            if !weatherMain.isEmpty {
                cell.configurator(with: weatherMain[indexPath.row], indexPath: indexPath)
            }
            
            return cell
            
        case .betweenSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BetweenSectionCell.reuseId, for: indexPath) as? BetweenSectionCell else { return UITableViewCell() }
            
            cell.lineView.backgroundColor = .white
            cell.lineView.alpha = 0.8
            
            return cell
            
        case .listHour:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourTableCell.reuseId, for: indexPath) as? HourTableCell else { return UITableViewCell() }
            
            cell.setupCollectionView()
            
            if !weather.isEmpty && !weatherMain.isEmpty {
                cell.weather = weather[indexPath.row]
                cell.aboutWeather = weatherMain[indexPath.row]
            }
            
            return cell
            
        case .betweenSections:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BetweenSectionCell.reuseId, for: indexPath) as? BetweenSectionCell else { return UITableViewCell() }
            
            cell.lineView.backgroundColor = .white
            cell.lineView.alpha = 0.8
            
            return cell
            
        case let .listDay(item: list):
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                WeekTableCell.reuseId, for: indexPath) as? WeekTableCell else { return UITableViewCell() }
            
            if !weather.isEmpty {
                cell.configurator(with: list, indexPath: indexPath)
            }
            
            return cell
        }
    }
}

