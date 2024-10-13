//
//  MainView+Actions.swift
//  SaveEarth
//
//  Created by 김용우 on 10/13/24.
//

import SwiftUI

extension MainView {

  func updateCurrentLocationTemperature() async throws {
    // FIXME: WeatherKit 인증 이슈 해결 필요
//    guard let response = try await weatherManager.fetchHistoricalTemperature(
//      location: .init(latitude: latitude, longitude: longitude)
//    ) else {
//      return print("Failed to fetch historical temperature")
//    }
//
    let currentTemperature = 6.0// response.currentTemperature
    let historicTemperature = 0.0// response.historicTemperature

    let count = abs(Int(historicTemperature - currentTemperature))

//    // TODO: 온도 차이 Display

    guard dayInfo == nil else {
      return print("Local weather already exists.")
    }

    add(
      DayInfo(
        date: Date.now,
        temperatureData: .init(
          historicTemperature: historicTemperature,
          currentTemperature: currentTemperature
        ),
        missionList: Mission.makeMissionList(count: count > 5 ? 5 : count)
      )
    )
  }

  private func add(_ dayInfo: DayInfo) {
    modelContext.insert(dayInfo)
  }

}

fileprivate extension Mission {

  static func makeMissionList(
    count: Int
  ) -> [Mission] {
    let questList: [String] = [
      "페트병 분리수거 하기 🫡",
      "에어컨 1도 낮추기 😎",
      "오늘 하루 텀블러 사용하기 😙",
      "종이컵 사용하지 않기",
      "대중교통 이용하기",
      "낮에는 전등 끄기",
      "사용하지 않는 콘센트 선 뽑아 놓기"
    ]
    var indexes = Set<Int>()

    while indexes.count < count {
      let randomIndex = Int.random(in: 0..<questList.count)
      indexes.update(with: randomIndex)
    }

    return indexes.map({ Mission(title: questList[$0]) })
  }
}
