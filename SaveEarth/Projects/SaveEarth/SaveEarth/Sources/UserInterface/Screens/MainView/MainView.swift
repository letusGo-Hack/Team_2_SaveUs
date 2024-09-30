//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

// TODO: 화면 분리 필요

struct MainView: View {

  // MARK: - Property

  @Bindable var store: StoreOf<MainFeature>
  @Query(sort: \DayInfo.date) private var dayInfos: [DayInfo]

  // MARK: - Body

  var content: some View { // UI 그리기
    ZStack {
      MapView(
        latitude: store.state.latitude,
        longitude: store.state.longitude
      )
      .overlay {
        TemperatureGradient(complete: store.state.completeRate)
          .ignoresSafeArea()
      }
      .overlay {
        if let missions = store.dayInfo?.missionList, missions.allSatisfy(\.isClear) {
          CompleteQuestView()
        } else {
          Image(systemName: "flame.fill")
            .foregroundColor(.red)
            .font(.largeTitle)
        }
      }
      if let dayInfo = store.dayInfo {
        VStack {
          Text(store.state.completeRate != 1 ? "뜨거운 지구를 구해주세요!! 😱" : "오늘도 지구를 조금 살려냈어요!")
            .font(.title)
            .padding(.vertical)
          Text("Temperature 🌡️")
            .font(.title2)
            .padding()
          HStack {
            Spacer()
            VStack(alignment: .leading) {
              Text("현재온도")
              Text(String(format: "%.2f℃", dayInfo.temperatureData.currentTemperature))
            }
            Spacer()
            VStack(alignment: .leading) {
              Text("평균온도")
              Text(String(format: "%.2f℃", dayInfo.temperatureData.historicTemperature))
            }
            Spacer()
          }
          .font(.title2)
          Spacer()
          if !dayInfo.missionList.allSatisfy(\.isClear) {
            QuestFloatingButton(
              numberOfQuests: UInt(dayInfo.missionList.filter { !$0.isClear }.count)
            ) {
              store.send(.questFloatingButtonTapped)
            }
            .transition(AppearingTransition())
            .animation(.spring(), value: store.state.destination)
          }
        }
      } else {
        ProgressView()
      }
    }
    .sheet(
      item: $store.scope(
        state: \.destination?.modal,
        action: \.destination.modal
      )
    ) { store in
      MissionListModal(store: store)
        .presentationDetents([.height(260)])
    }
  }

  var body: some View { // View 전처리 또는 의존성 주입 등 ex) onAppear, onDisAppear
    content
      .task {
        store.send(.fetch)
      }
      .onChange(of: dayInfos, initial: true) { _, _ in
        store.send(.onChange(dayInfos))
      }
  }
}

// MARK: - Preview

#Preview {
  MainView(
    store: .init(initialState: MainFeature.State()) {
      MainFeature()
    }
  )
}
