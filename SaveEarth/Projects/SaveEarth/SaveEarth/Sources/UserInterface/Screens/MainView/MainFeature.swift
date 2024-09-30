//
//  MainFeature.swift
//  SaveEarth
//
//  Created by 김용우 on 8/28/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct MainFeature {

  // MARK: - State

  @ObservableState
  struct State: Equatable {
    var dayInfo: DayInfo?
    var latitude = 76.571640
    var longitude = -41.666646
    var completeRate: Float = .zero

    @Presents var destination: Destination.State?
  }

  @Dependency(\.dayInfoModel) var dayInfoModel
  @Dependency(\.weatherManager) var weatherManager

  // MARK: - Action

  enum Action {
    case fetch
    case onChange([DayInfo])
    case questFloatingButtonTapped
    case destination(PresentationAction<Destination.Action>)
    case tempertureResponse(TemperatureData?)
  }

  // MARK: - Body

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case .fetch:
          guard state.dayInfo == nil else {
            return .none
          }
          return .run { [state = state] send in
            do {
//              let response = try await weatherManager.fetchHistoricalTemperature(
//                location: .init(latitude: state.latitude, longitude: state.longitude)
//              )
              await send(
                .tempertureResponse(
//                  response
                  .init(historicTemperature: 26.0, currentTemperature: 33.0) // FIXME: 네트워크 에러 임시처리
                )
              )
            } catch {
              print("!!!! \(error.localizedDescription)")
            }
          }

        case .onChange(let dayInfos):
          if let dayInfo = dayInfos.first(where: { $0.isToday }) {
            state.dayInfo = dayInfo
          }
          return .none

        case .questFloatingButtonTapped:
          guard let missionList = state.dayInfo?.missionList else {
            return .none
          }
          state.destination = .modal(.init(missionList: missionList))
          return .none

        case .destination(.presented(.modal(.toggle(let missionList)))):
          state.dayInfo?.missionList = missionList

          let clearedCount = missionList.filter(\.isClear).count
          state.completeRate = Float(clearedCount) / Float(missionList.count)

          if missionList.allSatisfy(\.isClear) {
            state.destination = nil
          }
          return .none

        case .destination(.presented(.modal(.dismiss))):
          state.destination = nil
          return .none

        case .destination:
          return .none

        case .tempertureResponse(let fetchedData):
          guard let fetchedData = fetchedData else {
            return .none
          }

          let currentTemperature = fetchedData.currentTemperature
          let historicTemperature = fetchedData.historicTemperature

          let count = abs(Int(historicTemperature - currentTemperature))
          let dayInfo = DayInfo(
            date: Date.now,
            temperatureData: .init(
              historicTemperature: historicTemperature,
              currentTemperature: currentTemperature
            ),
            missionList: Mission.makeMissionList(count: count > 5 ? 5 : count)
          )
          try? dayInfoModel.add(dayInfo)
          return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}

extension MainFeature {

  @Reducer(state: .equatable)
  enum Destination {
    case modal(MissionListModalFeature)
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
