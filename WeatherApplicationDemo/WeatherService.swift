//
//  WeatherService.swift
//  WeatherApplicationDemo
//
//  Created by 鈴木悠斗 on 2025/11/01.
//

import Foundation

class WeatherService {
    static let shared = WeatherService()
    private init() {}
    
    private let baseURL = "https://weather.tsukumijima.net/api/forecast/city/400040"
    
    enum WeatherError: Error, LocalizedError {
        case invalidURL
        case noData
        case decodingError
        case networkError(Error)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "無効なURLです"
            case .noData:
                return "データを取得できませんでした"
            case .decodingError:
                return "データの解析に失敗しました"
            case .networkError(let error):
                return "ネットワークエラー: \(error.localizedDescription)"
            }
        }
    }
    
    func fetchWeatherForecast() async throws -> WeatherForecast {
        guard let url = URL(string: baseURL) else {
            throw WeatherError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let weatherForecast = try decoder.decode(WeatherForecast.self, from: data)
            
            return weatherForecast
        } catch _ as DecodingError {
            throw WeatherError.decodingError
        } catch {
            throw WeatherError.networkError(error)
        }
    }
}
