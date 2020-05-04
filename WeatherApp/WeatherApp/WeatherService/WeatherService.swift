
import Alamofire
import Foundation


enum ServerError: Error {
    case badRequest
}

class WeatherService {
    
    let baseUrl = "http://api.openweathermap.org"
    
    let apiKey = "2493401262020cea63f72e36485cbe14"
    
    typealias Out = Swift.Result
    
    func sendRequest<T: Decodable>(url: String, method: HTTPMethod = .get, params: Parameters, completion: @escaping(Out<T, Error>) -> Void) {
        Alamofire.request(url, method: method, parameters: params)
            .responseData { (result) in
                guard let data = result.value else {
                    completion(.failure(ServerError.badRequest))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
        }
    }
    
    func getWeatherMain(city: String, complition: @escaping (Out<WeatherMain, Error>) -> Void)  {
        let path = "/data/2.5/weather"
        let params = [
            "q": city,
            "appid": apiKey
        ]
        let url = baseUrl + path
        
        sendRequest(url: url, method: .get, params: params) { complition ($0) }
    }
    
    func getWeather(city: String, complition: @escaping (Out<Weather, Error>) -> Void) {
        let path = "/data/2.5/forecast"
        let params = [
            "q": city,
            "appid": apiKey
        ]
        let url = baseUrl + path
        
        sendRequest(url: url, method: .get, params: params) { complition ($0) }
    }
}

