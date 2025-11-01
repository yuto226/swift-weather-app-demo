//
//  WeatherViewModel.swift
//  WeatherApplicationDemo
//
//  Created by 鈴木悠斗 on 2025/11/01.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherForecast: WeatherForecast?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let weatherService = WeatherService.shared
    
    func loadWeatherData() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let forecast = try await weatherService.fetchWeatherForecast()
                weatherForecast = forecast
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    var todaysForecast: DailyForecast? {
        weatherForecast?.forecasts.first
    }
    
    var locationString: String {
        guard let location = weatherForecast?.location else { return "" }
        return "\(location.prefecture)\(location.city)"
    }
    
    var currentTemperatureString: String {
        guard let today = todaysForecast else {
            return "気温データなし"
        }
        
        let maxTemp = today.temperature.max?.celsius
        let minTemp = today.temperature.min?.celsius
        
        // 両方とも取得できない場合
        if maxTemp == nil && minTemp == nil {
            return "気温データなし"
        }
        
        let maxTempText = maxTemp ?? "--"
        let minTempText = minTemp ?? "--"
        
        return "最高気温: \(maxTempText)°C / 最低気温: \(minTempText)°C"
    }
}
