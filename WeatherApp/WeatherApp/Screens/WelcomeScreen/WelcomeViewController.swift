
import UIKit

class WelcomeViewController: UIViewController {
    
    let iconWeather = UIImageView()
    let titleWeather = UILabel()
    let cityTextField = UITextField()
    let nextViewButton = UIButton()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "mainScreen")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        keyboardSetting()
        
        view.addSubview(imageView)
        view.addSubview(iconWeather)
        view.addSubview(titleWeather)
        view.addSubview(cityTextField)
        view.addSubview(nextViewButton)
        
        setupElements()
        setupIcon()
        setupTitle()
        setupTextField()
        setupButton()
    }
    
    func keyboardSetting() {
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(hideAction)
        reloadInputViews()
    }
    
    @objc func hideKeyBoard() {
        view.endEditing(true)
    }
    
    func setupElements() {
        iconWeather.translatesAutoresizingMaskIntoConstraints = false
        titleWeather.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        nextViewButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupIcon() {
        iconWeather.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80).isActive = true
        iconWeather.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80).isActive = true
        iconWeather.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        iconWeather.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconWeather.image = UIImage(named: "WeatherWelcome")
        iconWeather.heightAnchor.constraint(equalToConstant: 230).isActive = true
    }
    
    func setupTitle() {
       titleWeather.topAnchor.constraint(equalTo: iconWeather.bottomAnchor, constant: 20).isActive = true
        titleWeather.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80).isActive = true
        titleWeather.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80).isActive = true
        titleWeather.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleWeather.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleWeather.textColor = .white
        titleWeather.shadowColor = .darkText
        titleWeather.shadowOffset.height = 2
        titleWeather.shadowOffset.width = 2
        titleWeather.textAlignment = .center
        titleWeather.font = UIFont.boldSystemFont(ofSize: 30)
        titleWeather.text = "Weather"
    }
    
    func setupTextField() {
        cityTextField.topAnchor.constraint(equalTo: titleWeather.bottomAnchor, constant: 30).isActive = true
        cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cityTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        cityTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cityTextField.backgroundColor = .clear
        cityTextField.textColor = .darkGray
        cityTextField.attributedPlaceholder = .init(string: "City name")
        cityTextField.font = UIFont.boldSystemFont(ofSize: 25)
        cityTextField.tintColor = .darkGray
        cityTextField.textAlignment = .center
    }
    
    func setupButton() {
        nextViewButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20).isActive = true
        nextViewButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 170).isActive = true
        nextViewButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -170).isActive = true
        nextViewButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextViewButton.backgroundColor = .clear
        nextViewButton.setTitle("Show", for: .normal)
        nextViewButton.setTitleColor(.white, for: .normal)
        nextViewButton.layer.borderWidth = 1
        nextViewButton.layer.borderColor = UIColor.lightGray.cgColor
        nextViewButton.layer.cornerRadius = 10
        nextViewButton.addTarget(self, action: #selector(getNewScreen(_:)), for: .touchUpInside)
        nextViewButton.clipsToBounds = true
    }
}

extension WelcomeViewController {
    
    @objc func getNewScreen(_ sender: UIButton!) {
        guard let city = cityTextField.text else { return }
        
        if city.count <= 0 {
            let alert = UIAlertController(title: "Error", message: "Please, write city name.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        let weatherViewController = WeatherViewController()
        weatherViewController.cityName = city
        navigationController?.pushViewController(weatherViewController, animated: true)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
}

