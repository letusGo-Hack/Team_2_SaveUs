//
//  SaveEarthApp.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import SwiftData

@main
struct SaveEarthApp: App {
    
    let weatherManager: WeatherManager = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(weatherManager)
                .modelContainer(for: DayInfo.self)
        }
    }
}
