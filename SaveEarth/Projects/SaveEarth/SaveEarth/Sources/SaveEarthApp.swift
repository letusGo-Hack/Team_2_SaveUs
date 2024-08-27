//
//  SaveEarthApp.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftData
import SwiftUI

@main
struct SaveEarthApp: App {

  let weatherManager: WeatherManager = .init()

  var body: some Scene {
    WindowGroup {
      RootView(
        store: .init(
          initialState: RootFeature.State()
        ) {
          RootFeature()
        }
      )
      .environmentObject(weatherManager)
      .modelContainer(for: DayInfo.self)
    }
  }
}
