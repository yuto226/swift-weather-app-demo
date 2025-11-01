//
//  WeatherModels.swift
//  WeatherApplicationDemo
//
//  Created by 鈴木悠斗 on 2025/11/01.
//

import Foundation

struct WeatherForecast: Codable {
    let publicTime: String
    let publishingOffice: String
    let title: String
    let description: WeatherDescription
    let forecasts: [DailyForecast]
    let location: Location
}

struct WeatherDescription: Codable {
    let publicTime: String
    let bodyText: String
    let text: String
}

struct DailyForecast: Codable {
    let date: String
    let dateLabel: String
    let telop: String
    let detail: ForecastDetail
    let temperature: Temperature
    let image: WeatherImage
}

struct ForecastDetail: Codable {
    let weather: String
    let wind: String
    let wave: String
}

struct Temperature: Codable {
    let min: TemperatureValue?
    let max: TemperatureValue?
}

struct TemperatureValue: Codable {
    let celsius: String?
    let fahrenheit: String?
}


struct WeatherImage: Codable {
    let title: String
    let url: String
    let width: Int
    let height: Int
}

struct Location: Codable {
    let area: String
    let prefecture: String
    let district: String
    let city: String
}