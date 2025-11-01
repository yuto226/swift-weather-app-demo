//
//  ContentView.swift
//  WeatherApplicationDemo
//
//  Created by 鈴木悠斗 on 2025/11/01.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("天気情報を取得中...")
                        .scaleEffect(1.2)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        
                        Text("エラーが発生しました")
                            .font(.headline)
                        
                        Text(errorMessage)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("再試行") {
                            viewModel.loadWeatherData()
                        }
                        .buttonStyle(.bordered)
                    }
                } else if let todaysForecast = viewModel.todaysForecast {
                    VStack(spacing: 8) {
                            Text(viewModel.locationString)
                                .font(.title2)
                                .fontWeight(.semibold)
                        
                        VStack(spacing: 16) {
                            AsyncImage(url: URL(string: todaysForecast.image.url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Image(systemName: "cloud")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 100, height: 100)
                            
                            Text(todaysForecast.telop)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(viewModel.currentTemperatureString)
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        
                        Button("更新") {
                            viewModel.loadWeatherData()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "cloud")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("天気情報を取得してください")
                            .font(.headline)
                        
                        Button("天気情報を取得") {
                            viewModel.loadWeatherData()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("天気アプリ")
            .onAppear {
                viewModel.loadWeatherData()
            }
        }
    }
}

#Preview {
    ContentView()
}
