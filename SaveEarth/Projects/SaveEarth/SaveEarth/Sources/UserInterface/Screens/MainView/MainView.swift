//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct MainView: View {
  @Environment(WeatherManager.self) var weatherManager
  @Environment(\.modelContext) var modelContext
  @Query(sort: \DayInfo.date) private var dayInfos: [DayInfo]

  @State var latitude: CGFloat = 76.571640
  @State var longitude: CGFloat = -41.666646

  var dayInfo: DayInfo? { dayInfos.first(where: { $0.isToday }) }
  var isCleared: Bool? { dayInfo?.missionList.allSatisfy(\.isClear) }
  var completeRate: Float {
    if let missionList = dayInfo?.missionList {
      let clearedCount = missionList.filter(\.isClear).count
      return Float(clearedCount) / Float(missionList.count)
    } else {
      return .zero
    }
  }

  var body: some View {
    ZStack {
      MapView(
        latitude: $latitude,
        longitude: $longitude
      )
      .overlay {
        TemperatureGradient(complete: completeRate)
          .overlay(alignment: .center) {
            if let isCleared = isCleared {
              if isCleared {
                CompleteQuestView()
              } else {
                Image(systemName: "flame.fill")
                  .foregroundColor(.red)
                  .font(.largeTitle)
              }
            }
          }
          .ignoresSafeArea()
          .allowsHitTesting(false)
      }
      VStack {
        Spacer()
        Color.white.frame(height: 100)
      }
      .ignoresSafeArea(edges: .bottom)
      if let dayInfo = dayInfo {
        MainInterface(
          dayInfo: dayInfo,
          completeRate: completeRate
        )
      } else {
        ProgressView()
      }
    }
    .task {
      do {
        try await updateCurrentLocationTemperature()
      } catch {

      }
    }
    .toolbarVisibility(.hidden, for: .navigationBar)
  }
}

// MARK: - Preview

#Preview {
  MainView()
    .environment(Navigator())
    .environment(WeatherManager())
}
