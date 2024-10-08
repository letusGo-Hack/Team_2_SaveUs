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

  var body: some Scene {
    WindowGroup {
      RootView(
        store: .init(
          initialState: RootFeature.State()
        ) {
          RootFeature()
        }
      )
      .modelContainer(for: DayInfo.self)
    }
  }
}
